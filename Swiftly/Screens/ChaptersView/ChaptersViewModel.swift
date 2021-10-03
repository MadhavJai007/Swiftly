//  INFO49635 - CAPSTONE FALL 2021
//  ChaptersViewModel.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-27.

import Foundation
import SwiftUI

final class ChaptersViewModel: ObservableObject {

    @Published var didStartChapter = false
    
    @Published var isShowingChapterDetailView = false
    @Published var isShowingAccountView = false
    
    var startChapterIntent = false
    
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
}
