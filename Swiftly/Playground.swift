//
//  Playground.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-12.
//

import Foundation

/// This represents the chapter playground section
struct Playground: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let originalArr: [String]    
}
