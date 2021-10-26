//
//  ChapterLesson.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-26.
//

import Foundation

struct ChapterLesson:Identifiable,Equatable, Hashable {
    let id = UUID()
    let title: String
    let content: [String]
}
