//  INFO49635 - CAPSTONE FALL 2021
//  UserAccountViewModel.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import Firebase

final class UserAccountViewModel: ObservableObject {

    var logoutSuccessful = false
    
    @Published var isEditingAccount = false
    
    
    ///Todo: User object needs to be passed down the view hierarch from the login viewmodel
    
    @Published var loggedInUser = User(firstName: "",
                       lastName: "",
                       username: "",
                       email: "",
                       password: "",
                       dob : "",
                       country: ""
                    )
    
    

    
    
    
    var user = MockData.sampleUser
    

    /// Function to logout the user
    func logoutUser(){
        print(LoginViewModel.loggedInEmail)
        LoginViewModel.loggedInEmail = ""
        do {
            try Auth.auth().signOut()
            logoutSuccessful = true
        }
        catch {
            print("already logged out")
            logoutSuccessful = false
        }
    }
}
