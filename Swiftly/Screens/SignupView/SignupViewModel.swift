//  INFO49635 - CAPSTONE FALL 2021
//  SignupViewModel.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

final class SignupViewModel: ObservableObject {
    
    
    init(){
        //initializer
    }
    
    
    @Published var newUser = User(firstName: "",
                       lastName: "",
                       username: "",
                       email: "",
                       password: "",
                       dob : "",
                       country: "Canada"
                    )
    
    @Published var isBadSignup: Bool = false
    
    //boolean to ensure that email being used has not already been registered with Swiftly
    @Published var emailNotTaken: Bool = false
    
    @Published var alertInfo: AlertModel?
    
    private var db = Firestore.firestore()
    
    
    
    @Published var chaptersArr = [Chapter]()
    
    

    //Validation functions
    
    func isEmailValid() -> Bool{
        
        //must be in email@email.com format
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: newUser.email)
    }
    
    
    func isDateValid() -> Bool{
        
        //must be in dd/mm/yyyy format, only numerics
        
        let dateTest = NSPredicate(format: "SELF MATCHES %@", "^\\d{2}\\/\\d{2}\\/\\d{4}$")
        return dateTest.evaluate(with: newUser.dob)
    }
    
    
    func isPasswordValid() -> Bool{
        
        //Password must be at least 8 characters, no more than 15 characters, and must include at least one upper case letter, one lower case letter, and one numeric digit.
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=[^\\d_].*?\\d)\\w(\\w|[!@#$%]){7,20}")
        return passwordTest.evaluate(with: newUser.password)
    }
    
    func isUserNameValid() -> Bool{
        return newUser.username != ""
    }
    
    func isFirstNameValid() -> Bool{
        return newUser.firstName != ""
    }
    
    func isLastNameValid() -> Bool{
        return newUser.lastName != ""
    }
    
    func isCountryValid() -> Bool{
        return newUser.country != ""
    }
    
    
    var isSignUpComplete : Bool {
        if !isEmailValid(){
            return false
        }
        
        if !isPasswordValid(){
            return false
        }
        
        if !isDateValid(){
            return false
        }
        if !isUserNameValid(){
            return false
        }
        if !isFirstNameValid(){
            return false
        }
        if !isLastNameValid(){
            return false
        }
        if !isCountryValid(){
            return false
        }
        return true
    }
    
    func checkIfEmailExists(user: User){
        print("Email to be checked if it exists in Users collection is : \(user.email)")
        
        let emailCompared = user.email
        
//        print("After lowercased its : \(emailCompared)")
//
//        switch accountType {
//        case "Student":
//            print("search student collection")
//            let collectionRef = db.collection("Students")
//
//        case "Teacher":
//            print("search teacher collection")
//            let collectionRef = db.collection("Teachers")
//        default:
//            print("there is no default case")
//
//        }
        // Get your Firebase collection
           let collectionRef = db.collection("Users")

        // Get all the documents where the field username is equal to the String you pass, loop over all the documents.

        collectionRef.whereField("user_email", isEqualTo: emailCompared).getDocuments { (snapshot, err) in
               if let err = err {
                   print("Error getting document: \(err)")
               } else if (snapshot?.isEmpty)! {
                   print("Email is not taken. It is valid.")
                   self.emailNotTaken = true
               } else {
                   for document in (snapshot?.documents)! {
                       if document.data()["username"] != nil {
                           print("Email is Taken. It is NOT valid.")
                           self.emailNotTaken = false
                           
                       }
                   }
               }
           }
       
    }
    
    func checkIfEmailExistsCompletion(user: User, completion: () -> Void){
        print("check for students")
    }
    
    //adding user data to authentication database and Students/Teachers/Experts and Users firestore collections
    
    func authenticateUser(user: User){
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [self] user, error in
            print("Created authentication account successfully")
        }
    }
    
    func addUser(user: User, accountType: String){
        
        print("is \(accountType)")
        switch accountType {
        case "Student":
            
            var newStudentRef = db.collection("Students").document(user.username)
            
            newStudentRef.setData([
                "country": user.country,
                "date_of_birth": user.dob,
                "email": user.email,
                "firstname" : user.firstName,
                "username" : user.username,
                "lastName" : user.lastName,
                "password" : user.password
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Student successfully added!")
                }
            }
            
            
            newStudentRef = newStudentRef.collection("Classrooms").document("classroom_1")
            newStudentRef.setData(["instructor_id" : "placeholder"])
            
            
            for i in  0...chaptersArr.count-1{
                var playgroundArray = chaptersArr[i].playgroundArr
                
                newStudentRef.collection("Chapters").document("chapter_\(chaptersArr[i].chapterNum)").setData(["chapters_num" : chaptersArr[i].chapterNum,"chapters_name" : chaptersArr[i].name, "playground_status" : "incomplete", "chapter_status" : "incomplete", "theory_status" : "incomplete"])
                
                var questionsArray : [Int] = []
                
                for j in 0...playgroundArray.count-1{
                    questionsArray.append(0)
                    
                }
                var document = newStudentRef.collection("Chapters").document("chapter_\(chaptersArr[i].chapterNum)")
                document.updateData(["question_scores" : questionsArray])
            }
            
            
        case "Teacher":
            
            var newTeacherRef = db.collection("Teachers").document(user.username)
            
            newTeacherRef.setData([
                "country": user.country,
                "date_of_birth": user.dob,
                "email": user.email,
                "firstname" : user.firstName,
                "lastName" : user.lastName,
                "username" : user.username,
                "password" : user.password
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Teacher successfully added!")
                }
            }
            
            newTeacherRef = newTeacherRef.collection("Classrooms").document("classroom_1")
            newTeacherRef.setData(["instructor_id" : "placeholder"])
            
            for i in  0...chaptersArr.count-1{
                var playgroundArray = chaptersArr[i].playgroundArr
                
                newTeacherRef.collection("Chapters").document("chapter_\(chaptersArr[i].chapterNum)").setData(["chapters_num" : chaptersArr[i].chapterNum,"chapters_name" : chaptersArr[i].name, "playground_status" : "incomplete", "chapter_status" : "incomplete", "theory_status" : "incomplete"])
                
                var questionsArray : [Int] = []
                
                for j in 0...playgroundArray.count-1{
                    questionsArray.append(0)
                    
                }
                var document = newTeacherRef.collection("Chapters").document("chapter_\(chaptersArr[i].chapterNum)")
                document.updateData(["question_scores" : questionsArray])
            }
            
            
            
        default:
            print("Error in determining between Teacher and Student account type")
        }
        
        // adding user to the "Users" collection in database
        
        db.collection("Users").document(user.username).setData([
            "user_email": user.email,
            "user_type": accountType
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("User successfully added!")
            }
        }
            

    }
    
    func downloadChapterData(){
        db.collection("Chapters").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting chapter documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let chapterNum = document.data()["chapter_number"]! as! Int
                    let chapterName = document.data()["chapter_title"]! as! String
                    let chapterDifficulty = document.data()["chapter_difficulty"]! as! Int
                    let chapterSummary = document.data()["chapter_desc"]! as! String
                    let chapterLength = document.data()["chapter_length"]! as! Int
                    let iconName = document.data()["chapter_icon_name"]! as! String
                    
                    var chapterLessons = [ChapterLesson]()
                    
                    /// Getting lesson information
                    self.db.collection("Chapters").document(document.documentID).collection("lessons").getDocuments() {
                        (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting chapter lesson documents: \(err)")
                        } else {
                            
                            
                            
                            /// Grabbing the lesson data and appending it to the chapterLessons array
                            for chapterLessonDocument in querySnapshot!.documents {
                                let lesson_data = chapterLessonDocument.data()["lesson_content"]! as! [String]
                                
                                let newLesson = ChapterLesson(content: lesson_data)
                                
                                chapterLessons.append(newLesson)
                            }
                        }
                        
                    }
                    
                    self.db.collection("Chapters").document(document.documentID).collection("playground").getDocuments() {
                        (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting chapter documents: \(err)")
                        } else {
                            
                            var playgroundQuestions = [Playground]()
                            
                            
                            
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
                            
                            
                            
                            
                            self.chaptersArr.append(Chapter(chapterNum: chapterNum, name: chapterName, difficulty: chapterDifficulty, summary: chapterSummary, lessons: chapterLessons, length: chapterLength, iconName: iconName, playgroundArr: playgroundQuestions))
    
                        }
                    }
                }
            }
        }
        
        
    }
    
    
    func save(accountType: String){
        
        print("email: \(newUser.email)");
        print("password: \(newUser.password)")
        print("account type: \(accountType)")
        
        checkIfEmailExistsCompletion(user: newUser, completion:{
            print("now check for teachers")
        })
        
    
        emailNotTaken = false

        print("First we will check if the email already exists in our database using checkIfEmailExists().")
        checkIfEmailExists(user: newUser)


        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [self] (timer) in

            print("The email is not taken is : \(emailNotTaken)")
            if(emailNotTaken == false){
                self.isBadSignup = true
            }
            
        }

        let timer2 = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { [self] (timer) in

            print("The email is not taken is : \(emailNotTaken)")
            if(emailNotTaken == true){
                self.downloadChapterData()
                print("Since the email was valid, now execute authenticateUser() to add user to authenticator")
                self.authenticateUser(user: newUser)
            }
        }

        let timer3 = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [self] (timer) in
            if(emailNotTaken == true){
                print("Finally, since the email was valid, now execute addUser() to add user to collections")
                self.addUser(user: newUser, accountType: accountType)
            }

        }
        
    }
    
    
}
