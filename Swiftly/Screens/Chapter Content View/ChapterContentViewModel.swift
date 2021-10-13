//  INFO49635 - CAPSTONE FALL 2021
//  ChapterContentViewModelw.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-02.

import Foundation
import SwiftUI


final class ChapterContentViewModel: ObservableObject {
    
    
    /// Representing the current chapter and it's playground blocks
    var chapter: Chapter
    var chapterPlaygroundBlocks: [String]
    
    /// This is used to allow interaction with blocks
    @Published var activeBlocks: [InteractiveBlock]

    @Published var willQuitChapter = false
    @Published var willStartInteractiveSection = false
    @Published var willStartQuizSection = false

    let columns = [GridItem(.flexible())]
    

    /// Init variables with basic data
    init(){
        chapter = MockData.sampleChapter
        chapterPlaygroundBlocks = chapter.playgroundContent.originalArr
        activeBlocks = Array(repeating: InteractiveBlock(id: 0, content: ""), count: self.chapterPlaygroundBlocks.count)
    }
    
    
    /// Called to setup the playground environment
    func setupPlayground(selectedChapter: Chapter){
        
        /// Grabs chapter and chapter playground content data
        chapter = selectedChapter
        chapterPlaygroundBlocks = chapter.playgroundContent.originalArr
        
        /// Pre-populates array with interactive block objects
        activeBlocks = Array(repeating: InteractiveBlock(id: 0, content: ""), count: self.chapterPlaygroundBlocks.count)
        
        /// Copying content from playground blocks to array active blocks --> active blocks is the array that is copied and
        /// the user interacts with it. It gets compared to the original array to get user score.
        for i in 0..<chapterPlaygroundBlocks.count {
            activeBlocks[i] = InteractiveBlock(id: i, content: chapterPlaygroundBlocks[i])
        }
    }
    
    
    func quitChapter(){
        willQuitChapter = true
    }
    
    func startInteractiveSection(){
        willStartInteractiveSection = true
    }
    
    /// Compares users results to the results of the original array
    func completeInteractiveSection(){
        
        
        var userScore = 0
        
        for i in 0..<chapterPlaygroundBlocks.count {
            
            if (activeBlocks[i].content == chapterPlaygroundBlocks[i]){
                userScore += 1
            }
            
        }
        
        willStartQuizSection = true
        
        print("USER SCORE: \(userScore)")
    }
}
