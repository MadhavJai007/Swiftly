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
    
    private var db = Firestore.firestore()
    
    @Published var loggedInUser = User(firstName: "",
                       lastName: "",
                       username: "",
                       email: "",
                       password: "",
                       dob : "",
                       country: ""
                    )
    
    

    
    
    
    var user = MockData.sampleUser
    
    
    func loadUserData(){
        let collectionRef = db.collection("Students")
        print("searching with \(LoginViewModel.loggedInEmail)")

     // Get all the documents where the field username is equal to the String you pass, loop over all the documents.

        collectionRef.whereField("email", isEqualTo: LoginViewModel.loggedInEmail).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else if (snapshot?.isEmpty)! {
                print("Account not found. Shouldn't occur in this situation since user is already logged in.")
            } else {
                for document in (snapshot?.documents)! {
                    if document.data()["username"] != nil {
                        print("Account found!")
                        
                    }
                }
            }
        }

    }

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
