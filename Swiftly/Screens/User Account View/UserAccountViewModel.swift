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
    @Published var isUserInfoRetrieved = false
    

    
    
    
//    var user = MockData.sampleUser
    
    
    func loadUserData(loggedInEmail: String, accountType: String){
        print("searching with \(loggedInEmail)")
        switch accountType {
        case "Student":
            print("Searching students....")
            let collectionRef = db.collection("Students")
            collectionRef.whereField("email", isEqualTo: loggedInEmail).getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting document: \(err)")
                } else if (snapshot?.isEmpty)! {
                    print("Account not found. Shouldn't occur in this situation since user is already logged in.")
                } else {
                    let userObj = snapshot!.documents[0].data()
                    
                    self.loggedInUser.firstName = userObj["firstname"] as! String
                    self.loggedInUser.lastName = userObj["lastName"] as! String
                    self.loggedInUser.email = userObj["email"] as! String
                    self.loggedInUser.password = userObj["password"] as! String
                    self.loggedInUser.username = userObj["username"] as! String
                    self.loggedInUser.country = userObj["country"] as! String
                    self.loggedInUser.dob = userObj["date_of_birth"] as! String
                    
                    self.isUserInfoRetrieved = true
//                    for document in (snapshot?.documents)! {
//                        if document.data()["username"] != nil {
//                            print("Account found!")
//                            print(document.data())
//                        }
//                    }
                }
            }

        case "Teacher":
            print("Searching teachers....")
            let collectionRef = db.collection("Teachers")
            collectionRef.whereField("email", isEqualTo: loggedInEmail).getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting document: \(err)")
                } else if (snapshot?.isEmpty)! {
                    print("Account not found. Shouldn't occur in this situation since user is already logged in.")
                } else {
                    let userObj = snapshot!.documents[0].data()
                    
                    self.loggedInUser.firstName = userObj["firstname"] as! String
                    self.loggedInUser.lastName = userObj["lastName"] as! String
                    self.loggedInUser.email = userObj["email"] as! String
                    self.loggedInUser.password = userObj["password"] as! String
                    self.loggedInUser.username = userObj["username"] as! String
                    self.loggedInUser.country = userObj["country"] as! String
                    self.loggedInUser.dob = userObj["date_of_birth"] as! String
                    
                    self.isUserInfoRetrieved = true
                    
//                    for document in (snapshot?.documents)! {
//
//                        if document.data()["username"] != nil {
//                            print("Account found!")
//                            print(document.data())
//                        }
//                    }
                }
            }

        default:
            print("This default clause is not needed")
        }
  

     // Get all the documents where the field username is equal to the String you pass, loop over all the documents.
 

    }

    /// Function to logout the user
    func logoutUser(){
        do {
            try Auth.auth().signOut()
            self.isUserInfoRetrieved = false
            logoutSuccessful = true
            
            loggedInUser = User(firstName: "",
                                lastName: "",
                                username: "",
                                email: "",
                                password: "",
                                dob : "",
                                country: ""
                             )
        }
        catch {
            print("already logged out")
            logoutSuccessful = false
        }
    }
}
