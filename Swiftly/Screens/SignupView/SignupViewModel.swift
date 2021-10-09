//  INFO49635 - CAPSTONE FALL 2021
//  SignupViewModel.swift
//  Swiftly

import Foundation
import SwiftUI
import Firebase

/// Todo: Make sure user cannot create account with same username or email.

final class SignupViewModel: ObservableObject {
    
    /// Firebase Steps:
    ///    1. User signs up with all their info
    ///    2. Create new authentication element with the user's email, password, and ID
    ///    3. Create a new user collection element with all ^ this info + the rest
    ///    4. When the user logs in, grab their ID and then with that ID grab all the rest of their
    ///       information from the users collection.
    
    
    init(){
        //initializer
    }
    
    //store user inputted information into a User variable
    
    @Published var newUser = User(firstName: "",
                       lastName: "",
                       username: "",
                       email: "",
                       password: "",
                       dob: "",
                       country: "")
    
    private var db = Firestore.firestore()
    
    //push User variable to database
    
    func addUser(newUser: User){
        do{
            //let _ = try db.collection("Students").addDocument(from: newUser)
            
        }
        catch{
            print(error)
        }
    }
    
    
    
    
    
}
