//
//  User.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-03.
//

/// NOTE: This information is placeholder until User variables have been finalized (2021-10-03)

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
    
}


