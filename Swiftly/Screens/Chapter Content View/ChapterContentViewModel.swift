//  INFO49635 - CAPSTONE FALL 2021
//  ChapterContentViewModelw.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI


final class ChapterContentViewModel: ObservableObject {
    
    
    /// Representing the current chapter and it's playground questions
    var chapter: Chapter
    var chapterPlaygroundQuestions: [Playground]
    var selectedQuestion: Playground
    
    /// This is used to allow interaction with blocks
    @Published var activeBlocks: [InteractiveBlock]
    @Published var willQuitChapter = false
    @Published var willStartInteractiveSection = false
    @Published var willStartPlaygroundQuestion = false
    
    let columns = [GridItem(.flexible())]
    
    /// Init variables with basic data
    init(){
        chapter = MockData.sampleChapter
        chapterPlaygroundQuestions = chapter.playgroundArr
        selectedQuestion = chapterPlaygroundQuestions[0]
        activeBlocks = Array(repeating: InteractiveBlock(id: 0, content: ""), count: 1)
    }
    
    
    /// Called to setup the playground environment
    func setupPlaygroundQuestions(selectedChapter: Chapter){
        
        /// Grabs chapter and chapter playground questions
        chapter = selectedChapter
        chapterPlaygroundQuestions = chapter.playgroundArr
    }
    

    
    func setupPlayground(question: Playground){
        
        self.selectedQuestion = question
        
        
        let codeBlocks = selectedQuestion.originalArr
        
        /// Pre-populates array with interactive block objects
        activeBlocks = Array(repeating: InteractiveBlock(id: 0, content: ""), count: codeBlocks.count)
        
        /// Copying content from playground blocks to array active blocks --> active blocks is the array that is copied and
        /// the user interacts with it. It gets compared to the original array to get user score.
        for i in 0..<codeBlocks.count {
            activeBlocks[i] = InteractiveBlock(id: i, content: codeBlocks[i])
        }
        
        /// This will make navigation go
        self.willStartPlaygroundQuestion = true
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

        for i in 0..<selectedQuestion.originalArr.count {

            if (activeBlocks[i].content == selectedQuestion.originalArr[i]){
                userScore += 1
            }

        }

        

        print("USER SCORE: \(userScore)")
    }
}
