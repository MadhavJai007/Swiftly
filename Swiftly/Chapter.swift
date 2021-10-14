//
//  Chapter.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-09-27.
//

/// NOTE: This information is placeholder until chaper variables have be finalized (2021-10-03)

import Foundation
import SwiftUI

struct Chapter: Hashable, Identifiable {
    let id = UUID()
    let chapterNum: Int
    let name: String
    let difficulty: Int
    let completionStatus: String
    let lessonCompletion: String
    let playgroundCompletion: String
    let quizCompletion: String
    let summary: String
    let length: Int
    let iconName: String
    let playgroundArr: [Playground]
}


struct MockData {
    
   
    static let sampleUser = User(firstName: "Johhny", lastName: "Appleseed", username: "ilikeapples123", email: "test@email.com", password: "123456", dob: "2000/01/11", country: "Canada")
    
    static let sampleChapter = Chapter(chapterNum: 1, name: "Data Types", difficulty: 3, completionStatus: "Mid", lessonCompletion: "Yes", playgroundCompletion: "No", quizCompletion: "No", summary: "SUmmary", length: 24, iconName: "cpu", playgroundArr: [Playground(title: "Title", description: "Do this", originalArr: ["CODE", "CODE", "CODE"]), Playground(title: "Title", description: "Do this", originalArr: ["CODE", "CODE", "CODE"])])
    
    static let sampleChapter2 = Chapter(chapterNum: 1, name: "Data Types", difficulty: 3, completionStatus: "Mid", lessonCompletion: "Yes", playgroundCompletion: "No", quizCompletion: "No", summary: "SUmmary", length: 24, iconName: "cpu", playgroundArr: [Playground(title: "Title", description: "Do this", originalArr: ["CODE", "CODE", "CODE"]), Playground(title: "Title", description: "Do this", originalArr: ["CODE", "CODE", "CODE"])])
    
    static let sampleChapter3 = Chapter(chapterNum: 1, name: "Data Types", difficulty: 3, completionStatus: "Mid", lessonCompletion: "Yes", playgroundCompletion: "No", quizCompletion: "No", summary: "SUmmary", length: 24, iconName: "cpu", playgroundArr: [Playground(title: "Title", description: "Do this", originalArr: ["CODE", "CODE", "CODE"]), Playground(title: "Title", description: "Do this", originalArr: ["CODE", "CODE", "CODE"])])
    
    static let sampleChapter4 = Chapter(chapterNum: 1, name: "Data Types", difficulty: 3, completionStatus: "Mid", lessonCompletion: "Yes", playgroundCompletion: "No", quizCompletion: "No", summary: "SUmmary", length: 24, iconName: "cpu", playgroundArr: [Playground(title: "Title", description: "Do this", originalArr: ["CODE", "CODE", "CODE"]), Playground(title: "Title", description: "Do this", originalArr: ["CODE", "CODE", "CODE"])])
    
    
    static let Chapters = [
        sampleChapter,
        sampleChapter2,
        sampleChapter3
    ]
    
}
