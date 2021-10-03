//
//  User.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-03.
//

/// NOTE: This information is placeholder until User variables have been finalized (2021-10-03)

import Foundation
import SwiftUI

struct User: Hashable, Identifiable {

    let id = UUID()
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let password: String
    let dob: String
    let country: String
    
}


