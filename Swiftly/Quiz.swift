//
//  Quiz.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-12.
//

import Foundation

struct Quiz: Identifiable{
    var id = UUID()
    var questions: [Question]
}

struct Question: Identifiable {
    var id = UUID()
    var question: String
    var solution: String
    var options: [String]
}
