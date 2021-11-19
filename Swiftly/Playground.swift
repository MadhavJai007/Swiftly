//  INFO49635 - CAPSTONE FALL 2021
//  Playground.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation

/// This represents the chapter playground section
struct Playground: Identifiable, Hashable {
    var id = UUID()
    var fId = ""
    let title: String
    let description: String
    let type: String
    let originalArr: [String]
    var mcqOptions = [""]
    var mcqAnswers = [""]
}
