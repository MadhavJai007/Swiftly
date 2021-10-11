//  INFO49635 - CAPSTONE FALL 2021
//  ChapterContentViewModelw.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-02.

import Foundation
import SwiftUI


final class ChapterContentViewModel: ObservableObject {
    
    
    @Published var data: [InteractiveBlock]

    let columns = [GridItem(.flexible())]
    
    init() {
        data = Array(repeating: InteractiveBlock(id: 0), count: 4)
        for i in 0..<data.count {
            data[i] = InteractiveBlock(id: i)
        }
    }
    
    var chapter = MockData.sampleChapter
    
    @Published var willQuitChapter = false
    @Published var willStartInteractiveSection = false

    func quitChapter(){
        willQuitChapter = true
    }
    
    func startInteractiveSection(){
        willStartInteractiveSection = true
    }
    
    
}
