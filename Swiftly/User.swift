//  INFO49635 - CAPSTONE FALL 2021
//  User.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

/// TODO: Needs achievements and other field variables from firestore

import Foundation
import SwiftUI

struct User: Hashable, Identifiable, Codable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var password: String
    var dob: String
    var country: String
    var classroom: [UserClassroom]
}

struct UserClassroom: Hashable, Identifiable, Codable {
    var id = UUID()
    var classroomName = "placeholder"
    var subCode = ""
    var chapterProgress = [UserChapterProgress]()
    var clasroomTheoryStatus = "incomplete"
    var classroomPlaygroundStatus = "incomplete"
    var classroomStatus = "incomplete"
}

struct UserChapterProgress: Hashable, Identifiable, Codable {
    var id = UUID()
    var chapterStatus: String
    var chapterName: String
    var chapterNum: Int
    var playgroundStatus: String
    var questionScores: [Int]
    var questionAnswers: [UserQuestionAnswer]
    var questionProgress: [String]
    var theoryStatus: String
}

struct UserQuestionAnswer: Hashable, Identifiable, Codable {
    var id = UUID()
    var fId = ""
    var answers: [String]
}
