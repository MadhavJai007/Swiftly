//  INFO49635 - CAPSTONE FALL 2021
//  ChaptersViewModel.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import Firebase

final class ChaptersViewModel: ObservableObject {
    
    /// Published variables
    @Published var didStartChapter = false
    @Published var didSelectLeaderboard  = false
    @Published var isShowingChapterDetailView = false
    @Published var isShowingAccountView = false
    @Published var chaptersArr = [Chapter]()
    @Published var isUserLoggedIn = false
    @Published var classroomCode: String = ""
    @Published var jumpToPlayground = false
    
    /// Taken from firebase --> used to update UI components and store user entire chapter progress
    @Published var chaptersStatus = [String]()
    
    var loggedInAccountType : String = ""
    
    var loggedInUser = User(firstName: "",
                            lastName: "",
                            username: "",
                            email: "",
                            password: "",
                            dob : "",
                            country: "",
                            classroom: [])
    
    var willStartNextChapter = false
    
    var startChapterIntent = false
    
    
    var classroomIndex = 0
    var selectedChapterIndex = 0
    var selectedChapter: Chapter? {
        didSet {
            isShowingChapterDetailView = true
        }
    }
    
    /// 2 x 2 chapter columns
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    /// Called when the users starts the chapter
    func startChapter(){
        self.didStartChapter = true
    }
    
    /// Called when the user taps view leaderboard
    func viewLeaderboard(){
        self.didSelectLeaderboard = true
    }
    
    /// Called from views to pop to chapters view model
    func quitChapter(){
        self.didStartChapter = false
    }
    
    
    func changeClassroom(){
        print("changeClassroom")
    }
    
    func saveUserProgress(){
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: loggedInUser.email, password: loggedInUser.password)
        
        user?.reauthenticate(with: credential, completion: {(authResult, error) in
            if error != nil {
                print("error occured while reauthenticating")
            }else{
                print("Successfully Reauthenticated! ")
            }
        })
        
        /// Updating user progress
        for j in 0..<loggedInUser.classroom[0].chapterProgress.count{

            let updatingRef = db.collection(loggedInAccountType).document(loggedInUser.username).collection("Classrooms").document("classroom_1").collection("Chapters").document("chapter_\(j+1)")

            for i in 0..<loggedInUser.classroom[0].chapterProgress[j].questionAnswers.count
            {

                let data = loggedInUser.classroom[0].chapterProgress[j].questionAnswers[i].answers

                updatingRef.updateData([
                    "question_\(i+1)_answer": data
                ]){ err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }

            updatingRef.updateData([
                "chapter_status": loggedInUser.classroom[0].chapterProgress[j].chapterStatus,
                "playground_status": loggedInUser.classroom[0].chapterProgress[j].playgroundStatus,
                "theory_status": loggedInUser.classroom[0].chapterProgress[j].theoryStatus,
                "question_scores": loggedInUser.classroom[0].chapterProgress[j].questionScores,
                "question_progress": loggedInUser.classroom[0].chapterProgress[j].questionProgress
            ]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    
    /// Function that downloads the lessons (and chapters)
    func downloadLessons() {
        
        let db = Firestore.firestore()
        
        db.collection("Chapters").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting chapter documents: \(err)")
                self.isUserLoggedIn = false
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let chapterNum = document.data()["chapter_number"]! as! Int
                    let chapterName = document.data()["chapter_title"]! as! String
                    let chapterDifficulty = document.data()["chapter_difficulty"]! as! Int
                    let chapterSummary = document.data()["chapter_desc"]! as! String
                    let chapterLength = document.data()["chapter_length"]! as! Int
                    let iconName = document.data()["chapter_icon_name"]! as! String
                    
                    var chapterLessons = [ChapterLesson]()
                    let playgroundQuestions = [Playground]()
                    
                    var newChapter = Chapter(chapterNum: chapterNum, name: chapterName, difficulty: chapterDifficulty, summary: chapterSummary, lessons: chapterLessons, length: chapterLength, iconName: iconName, playgroundArr: playgroundQuestions)
                    
                    /// Getting lesson information
                    db.collection("Chapters").document(document.documentID).collection("lessons").getDocuments() {
                        (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting chapter lesson documents: \(err)")
                            self.isUserLoggedIn = false
                        } else {
                            
                            
                            /// Grabbing the lesson data and appending it to the chapterLessons array
                            for chapterLessonDocument in querySnapshot!.documents {
                                let lesson_data = chapterLessonDocument.data()["lesson_content"]! as! [String]
                                
                                let newLesson = ChapterLesson(content: lesson_data)
                                
                                chapterLessons.append(newLesson)
                            }
                            
                            newChapter.lessons = chapterLessons
                            
                            
                            self.chaptersArr.append(newChapter)
                            
                            print("LESSON CALL")
                            print("Name: \(newChapter.name)")
                            print("Lessons: \(newChapter.lessons.count)")
                            print("Playgrounds: \(newChapter.playgroundArr.count)")
                            
                            
                            /// Bubble sort used to sort the chapters via their chapter num
                            for i in 0..<self.chaptersArr.count {
                                for j in 1..<self.chaptersArr.count {
                                    if self.chaptersArr[j].chapterNum < self.chaptersArr[j-1].chapterNum {
                                        let tmp = self.chaptersArr[j-1]
                                        self.chaptersArr[j-1] = self.chaptersArr[j]
                                        self.chaptersArr[j] = tmp
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    
    /// Function that downloads the users playgrounds
    func downloadPlaygrounds(){
        
        let db = Firestore.firestore()
        
        
        db.collection("Chapters").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting chapter documents: \(err)")
                self.isUserLoggedIn = false
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let chapterNum = document.data()["chapter_number"]! as! Int
                    
                    var playgroundQuestions = [Playground]()
                    
                    /// Getting playground information
                    db.collection("Chapters").document(document.documentID).collection("playground").getDocuments() {
                        (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting chapter documents: \(err)")
                            self.isUserLoggedIn = false
                        } else {
                            
                            for playgroundDocument in querySnapshot!.documents {
                                
                                let title = playgroundDocument.data()["question_title"]! as! String
                                let description = playgroundDocument.data()["question_description"]! as! String
                                let type = playgroundDocument.data()["question_type"]! as! String
                                var blocks = playgroundDocument.data()["code_blocks"]! as! [String]
                                
                                
                                /// Since Firestore doesn't store line break, we have to save them as $s, then
                                /// once we download the data, we have to replace them with \n
                                for i in 0..<blocks.count {
                                    blocks[i] = blocks[i].replacingOccurrences(of: "$n", with: "\n")
                                }
                                
                                /// Only download mcq answers if the question type is MCQ
                                if (type == "mcq"){
                                    
                                    let mcqAnswers = playgroundDocument.data()["mcq_answers"]! as! [String]
                                    
                                    var playgroundQuestion = Playground(title: title, description: description, type: type, originalArr: blocks)
                                    
                                    playgroundQuestion.mcqAnswers = mcqAnswers
                                    
                                    playgroundQuestions.append(playgroundQuestion)
                                }else{
                                    
                                    let playgroundQuestion = Playground(title: title, description: description, type: type, originalArr: blocks)
                                    playgroundQuestions.append(playgroundQuestion)
                                    
                                }
                            }
                            
                            self.chaptersArr[chapterNum-1].playgroundArr = playgroundQuestions
                            
                            
                            print("PLAYGROUND CALL")
                            print("Name: \(self.chaptersArr[chapterNum-1].name)")
                            print("Lessons: \(self.chaptersArr[chapterNum-1].lessons.count)")
                            print("Playgrounds: \(self.chaptersArr[chapterNum-1].playgroundArr.count)")
                            
                            
                            self.isUserLoggedIn = true
                            
                        }
                    }
                }
            }
        }
        
        
    }
    
    /// Downloading all user data
    func loadUserData(loggedInEmail: String, accountType: String){
        
        let db = Firestore.firestore()
        
        /// Checking user account type
        switch accountType {
            
            /// Student
        case "Student":
            
            /// Grabbing students db
            let collectionRef = db.collection("Students")
            
            /// Finding matching emails
            collectionRef.whereField("email", isEqualTo: loggedInEmail).getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting document: \(err)")
                } else if (snapshot?.isEmpty)! {
                    print("Account not found. Shouldn't occur in this situation since user is already logged in.")
                } else {
                    
                    /// Grabbing entity for user
                    let userObj = snapshot!.documents[0].data()
                    
                    /// Grabbing basic user data
                    self.loggedInAccountType = "Students"
                    self.loggedInUser.firstName = userObj["firstname"] as! String
                    self.loggedInUser.lastName = userObj["lastName"] as! String
                    self.loggedInUser.email = userObj["email"] as! String
                    self.loggedInUser.password = userObj["password"] as! String
                    self.loggedInUser.username = userObj["username"] as! String
                    self.loggedInUser.country = userObj["country"] as! String
                    self.loggedInUser.dob = userObj["date_of_birth"] as! String
                    
                    /// Grabbing the classrooms
                    let enrolledClasrooms = db.collection("Students").document(self.loggedInUser.username).collection("Classrooms")
                    
                    enrolledClasrooms.getDocuments { (snapshot, err) in
                        
                        if err != nil {
                            print("Error: Couldn't grab user classrooms")
                        }
                        else if (snapshot?.isEmpty)!{
                            print("Error: User classrooms not found")
                        }
                        else{
                            print("Found classrooms...")
                            
                            /// Looping through each classroom
                            for j in 0..<snapshot!.documents.count {
                                
                                var userClassroom = UserClassroom() /// TODO: Grab classroom id from firestore
                                
                                /// Grabbing the current collection of chapters for chapter i
                                let classroomChapters = enrolledClasrooms.document("classroom_\(j+1)").collection("Chapters")
                                
                                /// Grabbing documents for chapter i
                                classroomChapters.getDocuments { (snapshot, err) in
                                    
                                    if err != nil {
                                        print("Error: Couldn't grab chapters...")
                                    }
                                    else if (snapshot?.isEmpty)!{
                                        print("Error: User chapters not found")
                                    }
                                    else{
                                        
                                        print("Found chapters...")
                                        
                                        /// Creating empty user chapter array
                                        var chaptersProgress = [UserChapterProgress]()
                                        
                                        /// Looping through the chapters
                                        for i in 0...snapshot!.documents.count-1{
                                            
                                            /// Data from firestore for chapter i
                                            let data = snapshot!.documents[i].data()
                                            
                                            var userQuestionAnswers = [UserQuestionAnswer]()
                                            
                                            /// Grabbing chapter info
                                            let chapterStatus = data["chapter_status"] as! String
                                            let chapterName = data["chapters_name"] as! String
                                            let chapterNum = data["chapters_num"] as! Int
                                            let playgroundStatus = data["playground_status"] as! String
                                            let questionScores = data["question_scores"] as! [Int]
                                            let theoryStatus = data["theory_status"] as! String
                                            let questionProgress = data["question_progress"] as! [String]
                                            
                                            
                                            var counter = 1
                                            while (data["question_\(counter)_answer"] != nil){
                                                
                                                let answer = data["question_\(counter)_answer"] as! [String]
                                                
                                                let newAnswer = UserQuestionAnswer(answers: answer)
                                                userQuestionAnswers.append(newAnswer)
                                                
                                                counter += 1
                                            }
                                            
                                            self.chaptersStatus.append(chapterStatus)
                                            
                                            /// Creating chapter object
                                            let chapter = UserChapterProgress(chapterStatus: chapterStatus, chapterName: chapterName, chapterNum: chapterNum, playgroundStatus: playgroundStatus, questionScores: questionScores, questionAnswers: userQuestionAnswers, questionProgress: questionProgress, theoryStatus: theoryStatus)
                 
                                            
                                            /// Appending chapter
                                            chaptersProgress.append(chapter)
                                            
                                        }
                                        
                                        
                                        
                                        /// Updating classroom chapter progress with the chapter progress
                                        /// Array of UserChapterProgress objects
                                        userClassroom.chapterProgress = chaptersProgress
                                        
                                        /// Appending classroom to user classrooms
                                        self.loggedInUser.classroom.append(userClassroom)
                                        
                                    }
                                }
                            }
                        }
                    }
                    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    //
                    //                        print("CLASSROOMCOUNT:\(self.loggedInUser.classroom.count)")
                    //
                    //                        for k in 0..<self.loggedInUser.classroom.count{
                    //
                    //                            for i in 0..<self.loggedInUser.classroom[k].chapterProgress.count {
                    //
                    //                                for j in 1..<self.loggedInUser.classroom[k].chapterProgress.count {
                    //
                    //                                    if self.loggedInUser.classroom[k].chapterProgress[j].chapterNum < self.loggedInUser.classroom[k].chapterProgress[j-1].chapterNum {
                    //                                        let tmp = self.loggedInUser.classroom[k].chapterProgress[j-1].chapterNum
                    //                                        self.loggedInUser.classroom[k].chapterProgress[j-1].chapterNum = self.loggedInUser.classroom[k].chapterProgress[j].chapterNum
                    //                                        self.loggedInUser.classroom[k].chapterProgress[j].chapterNum = tmp
                    //                                    }
                    //                                }
                    //                            }
                    //                        }
                    //                    }
                    
                    DispatchQueue.main.async{
                        /// After user account information has been downloaded, download the chapter data
                        //                        self.getChapterDocs()
                    }
                }
            }
            
        case "Teacher":
            print("Teacher")
            //            let collectionRef = db.collection("Teachers")
            //            collectionRef.whereField("email", isEqualTo: loggedInEmail).getDocuments { (snapshot, err) in
            //                if let err = err {
            //                    print("Error getting document: \(err)")
            //                } else if (snapshot?.isEmpty)! {
            //                    print("Account not found. Shouldn't occur in this situation since user is already logged in.")
            //                } else {
            //                    let userObj = snapshot!.documents[0].data()
            //                    self.loggedInAccountType =  "Teachers"
            //                    self.loggedInUser.firstName = userObj["firstname"] as! String
            //                    self.loggedInUser.lastName = userObj["lastName"] as! String
            //                    self.loggedInUser.email = userObj["email"] as! String
            //                    self.loggedInUser.password = userObj["password"] as! String
            //                    self.loggedInUser.username = userObj["username"] as! String
            //                    self.loggedInUser.country = userObj["country"] as! String
            //                    self.loggedInUser.dob = userObj["date_of_birth"] as! String
            //
            //
            //                    var userProgress = db.collection("Students").document(self.loggedInUser.username).collection("Chapters").document("chapter_1")
            //                }
            //            }
            
        default:
            print("This default clause is not needed")
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.downloadPlaygrounds()
        }
        
        
        
    }
}
