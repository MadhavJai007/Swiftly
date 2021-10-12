//  INFO49635 - CAPSTONE FALL 2021
//  ChaptersViewModel.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-27.

import Foundation
import SwiftUI
import Firebase

final class ChaptersViewModel: ObservableObject {

    @Published var didStartChapter = false
    @Published var didSelectLeaderboard  = false
    @Published var isShowingChapterDetailView = false
    @Published var isShowingAccountView = false
    @Published var chaptersArr = [Chapter]()
    @Published var isFinishedDownloadingChapters = false
    @Published var didErrorOccurGrabbingData = false
    
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
    
    /// Downloading chapters from Firebase and appending them to the chapters array
    func getChapterDocs() {
        
        let db = Firestore.firestore()
        
        db.collection("Chapters").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting chapter documents: \(err)")
                self.didErrorOccurGrabbingData = true
                self.isFinishedDownloadingChapters = false
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let chapterNum = document.data()["chapter_number"]! as! Int
                    let chapterName = document.data()["chapter_title"]! as! String
                    let chapterDifficulty = document.data()["chapter_difficulty"]! as! Int
                    let chapterCompletion = document.data()["chapter_completion"]! as! String
                    let lessonCompletion = document.data()["chapter_lesson_completion"]! as! String
                    let playgroundCompletion = document.data()["chapter_playground_completion"]! as! String
                    let quizCompletion = document.data()["chapter_quiz_completion"]! as! String
                    let chapterSummary = document.data()["chapter_desc"]! as! String
                    let chapterLength = document.data()["chapter_length"]! as! Int
                    let iconName = document.data()["chapter_icon_name"]! as! String
                    
                    let playgroundTitle = document.data()["playground_title"]! as! String
                    let playgroundDescription = document.data()["playground_description"]! as! String
                    let playgroundBlocks = document.data()["playground_code_blocks"]! as! [String]
                    
                    let playgroundContent = Playground(title:playgroundTitle, description: playgroundDescription, originalArr: playgroundBlocks)
                    
                    self.chaptersArr.append(Chapter(chapterNum: chapterNum, name: chapterName, difficulty: chapterDifficulty, completionStatus: chapterCompletion, lessonCompletion: lessonCompletion, playgroundCompletion: playgroundCompletion, quizCompletion: quizCompletion, summary: chapterSummary, length: chapterLength, iconName: iconName, playgroundContent: playgroundContent))
                    
//                    print("Chapter desc:  \(document.data()["chapter_desc"]!)")
//                    print("Chapter difficulty:  \(document.data()["chapter_difficulty"]!)")
//                    print("Chapter title:  \(document.data()["chapter_title"]!)")
//                    print("Chapter length:  \(document.data()["chapter_length"]!)")
//                    print("\(document.documentID) => \(document.data())")
                }
                
                self.isFinishedDownloadingChapters = true
                self.didErrorOccurGrabbingData = false
            }
        }
    }  
}
