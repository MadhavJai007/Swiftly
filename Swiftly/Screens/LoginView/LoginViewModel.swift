//  INFO49635 - CAPSTONE FALL 2021
//  LoginViewModel.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-30.

import Foundation
import SwiftUI
import Firebase

/// Todo: Only grab chapter information after user has logged in --> can be done with a completion handler.

final class LoginViewModel: ObservableObject {
    
    @Published var isSuccessful: Bool
    @Published var isBadLogin: Bool
    
    init(){
        isSuccessful = false
        isBadLogin = false
    }
    
    func testLogin(user: Int, password: Int) -> Bool{
        return user > password
    }
    
    /// Called when the user wants to login
    func login(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.isSuccessful = false
                self.isBadLogin = true
            } else{
                self.isSuccessful = true
                self.isBadLogin = false
            }
        }
    }
}
