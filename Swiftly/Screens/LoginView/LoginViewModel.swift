//  INFO49635 - CAPSTONE FALL 2021
//  LoginViewModel.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

final class LoginViewModel: ObservableObject {
    
    /// Published variables
    @Published var loggedInEmail : String = ""
    @Published var isShowingSignupView = false
    @Published var isSuccessful: Bool = false
    @Published var isBadLogin: Bool = false
    @Published var isLoggedOut: Bool = false
    @Published var accountMode:  String = "Undefined"
    @Published var accountTypeNotChosen: Bool =  false
    @Published var isLoading: Bool = false
    @Published var alertInfo: AlertModel?
    
    var attemptingLogin: Bool = false
    

    /// Firestore
    private var db = Firestore.firestore()
    
    /// Called when the user wants to login
    func login(email: String, password: String) {
//        let emailLowercased = email.lowercased()
        
        print(email)
        print(password)
        
        if self.accountMode == "Undefined" {
            print("Please select account type")
            alertInfo = AlertModel(id: .noAccountType, title: "Couldn't login", message: "Please select your account type")
            self.accountTypeNotChosen = true
            self.isLoading = false
        }
        else {
            
            Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
                
                if error != nil {
                    alertInfo = AlertModel(id: .noAccountType, title: "Bad login", message: "Email and/or password are incorrect.")
                    print("cmon dud")
                    self.isSuccessful = false
                    self.isBadLogin = true
                    self.isLoading = false
                    
                }else{
                    
                    switch self.accountMode {
                        
                    case "Student":
                        print("Checking the students collection...")
                        
                        // query to get user with specific email field
                        db.collection("Students").whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Email exists in google auth but was not found in firestore \(accountMode) collection.\n")
                                alertInfo = AlertModel(id: .emailNotFoundInCollection, title: "Error", message: "Email exists in google auth but was not found in firestore \(accountMode) collection. Please contact an administrator")
                                print("cmon dud")
                                self.isSuccessful = false
                                self.isBadLogin = true
                                self.isLoading = false
                                print(err)
                            } else {
                                print(querySnapshot!.documents)
                                // no users like that in collection
                                if(querySnapshot!.documents.isEmpty) {
                                    alertInfo = AlertModel(id: .emailNotFoundInCollection, title: "Error", message: "Email exists in google auth but was not found in firestore \(accountMode) collection. Please contact an administrator")
                                    self.isSuccessful = false
                                    self.isBadLogin = true
                                    self.isLoading = false
                                }
                            
                                else {
                                    //  self.accountMode = querySnapshot!.documents[0].data()["user_type"] as! String
                                    print("User account type => \(self.accountMode)")
        
                                    self.isSuccessful = true
                                    self.isBadLogin = false
                                    self.accountTypeNotChosen = false
                                    
                                }
                            }
                        }
                    case "Teacher":
                        print("Checking the teachers collection...")
                        // query to get user with specific email field
                        db.collection("Teachers").whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Email exists in google auth but was not found in firestore \(accountMode) collection.\n")
                                alertInfo = AlertModel(id: .emailNotFoundInCollection, title: "Error", message: "Email exists in google auth but was not found in firestore \(accountMode) collection. Please contact an administrator")
                                print("cmon dud")
                                self.isSuccessful = false
                                self.isBadLogin = true
                                print(err)
                                self.isLoading = false
                            } else {
                                print(querySnapshot!.documents)
                                // no users like that in collection
                                if(querySnapshot!.documents.isEmpty) {
                                    alertInfo = AlertModel(id: .emailNotFoundInCollection, title: "Error", message: "Email exists in google auth but was not found in firestore \(accountMode) collection. Please contact an administrator")
                                    self.isSuccessful = false
                                    self.isBadLogin = true
                                    self.isLoading = false
                                }
                            
                                else {
                                    //  self.accountMode = querySnapshot!.documents[0].data()["user_type"] as! String
                                    print("User account type => \(self.accountMode)")
        
                                    self.isSuccessful = true
                                    self.isBadLogin = false
                                    self.accountTypeNotChosen = false
                                    
                                }
                            }
                        }
                    case "Experts":
                        print("Checking the experts collection...")
                        // query to get user with specific email field
                        db.collection("Students").whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Email exists in google auth but was not found in firestore \(accountMode) collection.\n")
                                alertInfo = AlertModel(id: .emailNotFoundInCollection, title: "Error", message: "Email exists in google auth but was not found in firestore \(accountMode) collection. Please contact an administrator")
                                print("cmon dud")
                                self.isSuccessful = false
                                self.isBadLogin = true
                                self.isLoading = false
                                print(err)
                            } else {
                                print(querySnapshot!.documents)
                                // no users like that in collection
                                if(querySnapshot!.documents.isEmpty) {
                                    alertInfo = AlertModel(id: .emailNotFoundInCollection, title: "Error", message: "Email exists in google auth but was not found in firestore \(accountMode) collection. Please contact an administrator")
                                    self.isSuccessful = false
                                    self.isBadLogin = true
                                    self.isLoading = false
                                }
                            
                                else {
                                    //  self.accountMode = querySnapshot!.documents[0].data()["user_type"] as! String
                                    print("User account type => \(self.accountMode)")
        
                                    self.isSuccessful = true
                                    self.isBadLogin = false
                                    self.accountTypeNotChosen = false
                                    
                                }
                            }
                        }
                    default:
                        print("This shouldnt ever and will never happen")
                        self.accountTypeNotChosen = true
                        self.isLoading.toggle()
                    }
//                     query to get user with specific email field
//                    db.collection("Users").whereField("user_email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
//                        if let err = err {
//                            print("Email exists in google auth but was not found in firestore 'Users' collection.\n")
//                            print(err)
//                        } else {
//                            // querySnapshot returns an array if it found something
//                            // But the array should have only ONE item in it.
//                            // following statements assume that there is only one item in the snapshot array
//                            /// TODO:   Implement check that sees if there is more than one item fot whatever reason
//                            self.accountMode = querySnapshot!.documents[0].data()["user_type"] as! String
//                            print("User account type => \(self.accountMode)")
//
//                            //                            for document in querySnapshot!.documents {
//                            //                                print("User email => \(document.data()["user_email"]!)")
//                            //                                print("User account type => \(document.data()["user_type"]!)")
//                            //
//
//                            self.isSuccessful = true
//                            self.isBadLogin = false
//                            self.accountTypeNotChosen = false
//                        }
//                    }
        } 
            }
        }
    }
}
