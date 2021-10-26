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
    var selectedQuestionIndex: Int
    
    let columns = [GridItem(.flexible())]
    
    /// This is used to allow interaction with blocks
    @Published var activeBlocks: [InteractiveBlock]
    @Published var willQuitChapter = false
    @Published var willStartInteractiveSection = false
    @Published var willStartPlaygroundQuestion = false
    @Published var chapterButtonText = "Next"
    @Published var isFinalChapter = false
    @Published var willStartNextQuestion = false
    @Published var mcqOptions: [String] = []
    @Published var mcqUserAnswers: [String] = []
    
    
    /// Init variables with basic data
    init(){
        chapter = MockData.sampleChapter
        chapterPlaygroundQuestions = chapter.playgroundArr
        selectedQuestion = chapterPlaygroundQuestions[0]
        selectedQuestionIndex = 0
        activeBlocks = Array(repeating: InteractiveBlock(id: 0, content: ""), count: 1)
    }
    
    /// Function which modifies the button text in the view
    func checkQuestionInfo(){
        
        /// If the question is the last one, otherwise ...
        if (selectedQuestionIndex == chapterPlaygroundQuestions.count-1){
            chapterButtonText = "Submit"
            isFinalChapter = true
        }else{
            chapterButtonText = "Next"
            isFinalChapter = false
        }
    }
    
    /// Called to setup the playground environment
    func setupPlaygroundQuestions(selectedChapter: Chapter){
        
        /// Grabs chapter and chapter playground questions
        chapter = selectedChapter
        chapterPlaygroundQuestions = chapter.playgroundArr
    }
    
    /// Called to start the next playground question
    func startNextPlaygroundQuestion(){
        
        /// Incrementing to next chapter
        selectedQuestionIndex += 1
        selectedQuestion = chapterPlaygroundQuestions[selectedQuestionIndex]
        
        /// Setting up the next playground
        setupPlayground(question: selectedQuestion, questionIndex: selectedQuestionIndex)
        
        willStartNextQuestion = true
    }
    
    
    /// Called from InteractiveQuestionsView
    func setupPlayground(question: Playground, questionIndex: Int){
        
        selectedQuestion = question
        selectedQuestionIndex = questionIndex
        
        if (selectedQuestion.type == "code_blocks"){
            
            var codeBlocks = selectedQuestion.originalArr
            
            /// TODO: Only call this if the user does not have save data for this
            codeBlocks.shuffle()
            
            /// Pre-populates array with interactive block objects
            activeBlocks = Array(repeating: InteractiveBlock(id: 0, content: ""), count: codeBlocks.count)
            
            /// Copying content from playground blocks to array active blocks --> active blocks is the array that is copied and
            /// the user interacts with it. It gets compared to the original array to get user score.
            for i in 0..<codeBlocks.count {
                activeBlocks[i] = InteractiveBlock(id: i, content: codeBlocks[i])
            }
        }else if (selectedQuestion.type == "mcq"){
            mcqOptions = selectedQuestion.originalArr
        }
        
        /// This will make navigation go
        willStartPlaygroundQuestion = true
        
        /// Checking question info
        checkQuestionInfo()
        
    }
    
    /// Quits the current chapter
    func quitChapter(){
        willQuitChapter = true
    }
    
    /// Starts interactive section of chapter
    func startInteractiveSection(){
        willStartInteractiveSection = true
    }
    
    /// Used to retrieve the score of the user
    func getQuestionScore(){
        
        var userScore = 0
        
        /// Checking code block answer
        if (selectedQuestion.type == "code_blocks"){
            
            for i in 0..<selectedQuestion.originalArr.count {
                
                if (activeBlocks[i].content == selectedQuestion.originalArr[i]){
                    userScore += 1
                }
            }
            
        /// Checking mcq answer
        }else{
            
            if (mcqUserAnswers.isEmpty == false){
                for i in 0..<mcqUserAnswers.count {
                    if (selectedQuestion.originalArr.contains(mcqUserAnswers[i])){
                        userScore += 1
                    }
                }
            }
        } 
        print("USER SCORE: \(userScore)")
    }
    
    /// Finishes the playground section and returns to the playground questions view
    func completeInteractiveSection(){
        willStartPlaygroundQuestion = false
    }
}

