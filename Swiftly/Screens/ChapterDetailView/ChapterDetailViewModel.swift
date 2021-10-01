//
//  ChapterDetailViewModel.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-01.
//

import Foundation
import SwiftUI

final class ChapterDetailViewModel: ObservableObject {
    
    @Published var isSelected: Bool
    
    
    init() {
        isSelected = false
    }
    
    
    func startChapter(chapter: Chapter){
        
    }
    
    
}
