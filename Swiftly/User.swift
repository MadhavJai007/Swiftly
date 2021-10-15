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

}

