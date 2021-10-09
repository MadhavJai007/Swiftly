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
    
    
    var startChapterIntent = false
    
    
    init(){
    }

    
    var selectedChapter: Chapter? {
        didSet {
            isShowingChapterDetailView = true
        }
    }
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]

    func startChapter(){
        self.didStartChapter = true
    }
    
    func viewLeaderboard(){
        self.didSelectLeaderboard = true
    }
    
    /// Downloading chapters from Firebase and appending them to the chapters array
    func getChapterDocs() {
        let db = Firestore.firestore()
        db.collection("Chapters").getDocuments() { (querySnapshot, err) in
            if let err = err {
                
                /// Todo: Inform user some error happened -> don't let them access chapters page
                print("Error getting chapter documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.chaptersArr.append(Chapter(chapterNum: document.data()["chapter_number"]! as! Int, name: document.data()["chapter_title"]! as! String, difficulty: document.data()["chapter_difficulty"]! as! Int, completionStatus: "Incomplete", summary: document.data()["chapter_desc"]! as! String, length: document.data()["chapter_length"]! as! Int, iconName: "cpu"))
                    print("Chapter desc:  \(document.data()["chapter_desc"]!)")
                    print("Chapter difficulty:  \(document.data()["chapter_difficulty"]!)")
                    print("Chapter title:  \(document.data()["chapter_title"]!)")
                    print("Chapter length:  \(document.data()["chapter_length"]!)")
                    print("\(document.documentID) => \(document.data())")
                }
                
                self.isFinishedDownloadingChapters = true
            }
        }
    }  
}
