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
    
    var startChapterIntent = false
    
    
    init(){
        /// Call getChapterDocs() in here so there's no race between logging in and downloading chapters
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
    
    func getChapterDocs() {
        let db = Firestore.firestore()
        db.collection("Chapters").getDocuments() { (querySnapshot, err) in
            if let err = err {
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
            }
        }
    }
    
}
