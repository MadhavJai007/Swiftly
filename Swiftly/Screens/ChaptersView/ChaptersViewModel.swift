//  INFO49635 - CAPSTONE FALL 2021
//  ChaptersViewModel.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import Firebase

final class ChaptersViewModel: ObservableObject {
    

    
    @Published var didStartChapter = false
    @Published var didSelectLeaderboard  = false
    @Published var isShowingChapterDetailView = false
    @Published var isShowingAccountView = false
    @Published var chaptersArr = [Chapter]()
    @Published var isUserLoggedIn = false
    @Published var classroomCode: String = ""
    
    var startChapterIntent = false
    
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
    
    /// TODO: Organize chapters so that they are in the correct order
    /// Downloading chapters from Firebase and appending them to the chapters array
    func getChapterDocs() {
        
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
                        }
                        
                    }
            
                    /// Getting playground information
                    db.collection("Chapters").document(document.documentID).collection("playground").getDocuments() {
                        (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting chapter documents: \(err)")
                            self.isUserLoggedIn = false
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
                                
                                let playgroundQuestion = Playground(title: title, description: description, type: type, originalArr: blocks)
                                
                                playgroundQuestions.append(playgroundQuestion)
                            }
                            
                            self.chaptersArr.append(Chapter(chapterNum: chapterNum, name: chapterName, difficulty: chapterDifficulty, summary: chapterSummary, lessons: chapterLessons, length: chapterLength, iconName: iconName, playgroundArr: playgroundQuestions))
                            
                            self.isUserLoggedIn = true
                        }     
                    }
                    //                    print("Chapter desc:  \(document.data()["chapter_desc"]!)")
                    //                    print("Chapter difficulty:  \(document.data()["chapter_difficulty"]!)")
                    //                    print("Chapter title:  \(document.data()["chapter_title"]!)")
                    //                    print("Chapter length:  \(document.data()["chapter_length"]!)")
                    //                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}


