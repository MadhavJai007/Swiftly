//  INFO49635 - CAPSTONE FALL 2021
//  Chapter.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

/// NOTE: This information is placeholder until chaper variables have be finalized (2021-10-03)

import Foundation
import SwiftUI

struct Chapter: Hashable, Identifiable {
    let id = UUID()
    var chapterNum: Int
    var name: String
    var difficulty: Int
    var summary: String
    var lessons: [ChapterLesson]
    var length: Int
    var iconName: String
    var playgroundArr: [Playground]
    
    
    /// Get ID
    func getId() -> UUID {
        return id
    }
    
    /// Getting chapter num
    func getChapterNum() -> Int {
        return chapterNum
    }
    
    /// Setting chapter num
    mutating func setChapterNum(num: Int) {
        chapterNum = num
    }
    
    /// Getting name
    func getName() -> String {
        return name
    }
    
    /// Setting name
    mutating func setName(chaptName: String) {
        name = chaptName
    }
    
    /// Getting difficulty
    func getDifficulty() -> Int {
        return difficulty
    }
    
    /// Setting difficulty
    mutating func setDifficulty(diff: Int) {
        difficulty = diff
    }
    
    /// Getting summary
    func getSummary() -> String {
        return summary
    }
    
    /// Setting summary
    mutating func setSummary(sum: String){
        summary = sum
    }
    
    /// Getting lessons
    func getLessons() -> [ChapterLesson]{
        return lessons
    }
    
    /// Setting lessons
    mutating func setLessons(lesson: [ChapterLesson]){
        lessons = lesson
    }
    
    /// Getting length
    func getLength() -> Int {
        return length
    }
    
    /// Setting length
    mutating func setLength(len: Int) {
        length = len
    }
    
    /// Getting icon name
    func getIconName() -> String {
        return iconName
    }
    
    /// Setting icon name
    mutating func setIconName(name: String){
        iconName = name
    }
    
    /// Getting playground
    func getPlayground() -> [Playground]{
        return playgroundArr
    }
    
    /// Setting playground
    mutating func setPlayground(playground: [Playground]){
        playgroundArr = playground
    }
    
    
    
}


struct MockData {
    
    static let sampleUser = User(firstName: "Johhny", lastName: "Appleseed", username: "ilikeapples123", email: "test@email.com", password: "123456", dob: "2000/01/11", country: "Canada", classroom: [UserClassroom()])
    
    static let sampleChapter = Chapter(chapterNum: 1, name: "Data Types", difficulty: 3, summary: "SUmmary", lessons: [ChapterLesson(content: ["ABC", "DEF"])], length: 24, iconName: "cpu", playgroundArr: [Playground(title: "Title", description: "Do this", type: "code_blocks", originalArr: ["CODE", "CODE", "CODE"]), Playground(title: "Title", description: "Do this", type: "code_blocks", originalArr: ["CODE", "CODE", "CODE"])])
    
    static let sampleChapter2 = Chapter(chapterNum: 1, name: "Data Types", difficulty: 3, summary: "SUmmary", lessons: [ChapterLesson(content: ["ABC", "DEF"])], length: 24, iconName: "cpu", playgroundArr: [Playground(title: "Title", description: "Do this", type: "code_blocks", originalArr: ["CODE", "CODE", "CODE"]), Playground(title: "Title", description: "Do this", type: "code_blocks", originalArr: ["CODE", "CODE", "CODE"])])
    
    static let sampleChapter3 = Chapter(chapterNum: 1, name: "Data Types", difficulty: 3, summary: "SUmmary", lessons: [ChapterLesson(content: ["ABC", "DEF"])], length: 24, iconName: "cpu", playgroundArr: [Playground(title: "Title", description: "Do this", type: "code_blocks", originalArr: ["CODE", "CODE", "CODE"]), Playground(title: "Title", description: "Do this", type: "code_blocks", originalArr: ["CODE", "CODE", "CODE"])])
    
    static let sampleChapter4 = Chapter(chapterNum: 1, name: "Data Types", difficulty: 3, summary: "SUmmary", lessons: [ChapterLesson(content: ["ABC", "DEF"])], length: 24, iconName: "cpu", playgroundArr: [Playground(title: "Title", description: "Do this", type: "code_blocks", originalArr: ["CODE", "CODE", "CODE"]), Playground(title: "Title", description: "Do this", type: "code_blocks", originalArr: ["CODE", "CODE", "CODE"])])
    
    
    static let Chapters = [
        sampleChapter,
        sampleChapter2,
        sampleChapter3
    ]
    
}
