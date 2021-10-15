//  INFO49635 - CAPSTONE FALL 2021
//  Playground.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation

/// This represents the chapter playground section
struct Playground: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let originalArr: [String]    
}
