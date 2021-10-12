//
//  InteractiveBlock.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-11.
//

import Foundation
import SwiftUI


/// Represents an interactive block that are contained within playground
struct InteractiveBlock: Identifiable, Equatable, Hashable {
    let id: Int
    let content: String
}
