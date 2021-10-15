//  INFO49635 - CAPSTONE FALL 2021
//  LoginViewModel.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-30.

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

/// Todo: Only grab chapter information after user has logged in --> can be done with a completion handler.

final class LoginViewModel: ObservableObject {
    
    init(){
        
    }
    
    @Published var isSuccessful: Bool = false
    @Published var isBadLogin: Bool = false
    @Published var isLoggedOut: Bool = false
    @Published var accountMode:  String = "something"
    private var db = Firestore.firestore()
    
    
//    init(){
//        isSuccessful = false
//        isBadLogin = false
//        isLoggedOut = false
//    }
    

    
    func testLogin(user: Int, password: Int) -> Bool{
        return user > password
    }
    
    /// Called when the user wants to login
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if error != nil {
                self.isSuccessful = false
            } else{
                
                // check the users collection in firestore for account type
//                let usersRef = db.collection("Users")

                // query to get user with specific email field
                db.collection("Users").whereField("user_email", isEqualTo: email)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Email exists in google auth but was not found in firestore 'Users' collection.\n")
                            print(err)
                        } else {
                            // querySnapshot returns an array if it found something
                            // But the array should have only ONE item in it.
                            // following statements assume that there is only one item in the snapshot array
                            /// TODO:   Implement check that sees if there is more than one item fot whatever reason
                            self.accountMode = querySnapshot!.documents[0].data()["user_type"] as! String
                            print("User account type => \(self.accountMode)")
                            
//                            for document in querySnapshot!.documents {
//                                print("User email => \(document.data()["user_email"]!)")
//                                print("User account type => \(document.data()["user_type"]!)")
//                            }
                        }
                    }
                
                
                self.isSuccessful = true
            }
        }
    }
}
