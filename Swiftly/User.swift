//
//  User.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-03.
//

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

}

