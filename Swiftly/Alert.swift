//  INFO49635 - CAPSTONE FALL 2021
//  Alert.swift
//  Swiftly
//
//  Created by Madhav Jaisankar on 2021-10-19.
//

import SwiftUI

struct AlertModel: Identifiable {
    enum AlertType {
        case badLogin
        case noAccountType
        case emailNotFoundInCollection  // this will never happen
    }
    
    let id: AlertType
    let title: String
    let message: String
}

