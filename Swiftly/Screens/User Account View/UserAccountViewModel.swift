//  INFO49635 - CAPSTONE FALL 2021
//  UserAccountViewModel.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-03.

import Foundation
import SwiftUI
import Firebase

final class UserAccountViewModel: ObservableObject {
    
    @Published var isUserLoggedIn = false
    
    ///Todo: User object needs to be passed down the view hierarch from the login viewmodel
    var user = MockData.sampleUser
    
    
    
    func logoutUser(){
        
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
        }
        catch {
            print("already logged out")
            
        }
        
        
    }
}
