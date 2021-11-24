//
//  ChapterLesson.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-26.
//

import Foundation

struct ChapterLesson:Identifiable,Equatable, Hashable {
    let id = UUID()
    var content: [String]
    
    /// Getting ID
    func getID() -> UUID{
        return id
    }
    
    /// Getting content
    func getContent() -> [String]{
        return content
    }
    
    /// Setting content
    mutating func setContent(lessonContent: [String]) {
        content = lessonContent
    }
}


