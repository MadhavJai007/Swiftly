//
//  Chapter.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-09-27.
//

import Foundation
import SwiftUI

struct Chapter: Hashable, Identifiable {
    
    let id = UUID()
    let chapterNum: Int
    let name: String
    let difficulty: Int
    let completionStatus: String
    let summary: String
    let length: Int
    let iconName: String
    
}


struct MockData {
    
    
    static let sampleChapter = Chapter(chapterNum: 1, name: "Multi-Threading", difficulty: 3, completionStatus: "Incomplete", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec ornare purus, eget aliquam magna. Pellentesque bibendum bibendum venenatis", length: 15, iconName: "cpu")
    
    
    static let Chapters = [
        Chapter(chapterNum: 1, name: "Multi-Threading", difficulty: 3, completionStatus: "Incomplete", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec ornare purus, eget aliquam magna. Pellentesque bibendum bibendum venenatis", length: 15, iconName: "cpu"),
        Chapter(chapterNum: 2, name: "Multi-Threading", difficulty: 3, completionStatus: "Incomplete", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec ornare purus, eget aliquam magna. Pellentesque bibendum bibendum venenatis", length: 15, iconName: "cpu"),
        Chapter(chapterNum: 3, name: "Multi-Threading", difficulty: 3, completionStatus: "Incomplete", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec ornare purus, eget aliquam magna. Pellentesque bibendum bibendum venenatis", length: 15, iconName: "cpu"),
        Chapter(chapterNum: 4, name: "Multi-Threading", difficulty: 3, completionStatus: "Incomplete", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec ornare purus, eget aliquam magna. Pellentesque bibendum bibendum venenatis", length: 15, iconName: "cpu"),
        Chapter(chapterNum: 5, name: "Multi-Threading", difficulty: 3, completionStatus: "Incomplete", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec ornare purus, eget aliquam magna. Pellentesque bibendum bibendum venenatis", length: 15, iconName: "cpu"),
    ]
    
}
