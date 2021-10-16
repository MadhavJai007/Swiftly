//  INFO49635 - CAPSTONE FALL 2021
//  SignupViewModel.swift
//  Swiftly

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


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
    
    
    //create newUser variable to store account information to be passed to the database
    
    @Published var newUser = User(firstName: "",
                       lastName: "",
                       username: "",
                       email: "",
                       password: "",
                       dob: "",
                       country: ""
                    )
    
    private var db = Firestore.firestore()
    
    //boolean to ensure that email being used has not already been registered with Swiftly
    var emailNotTaken = true
    
    ///Todo: Check if user already exists --> if they do, don't add user
    func authenticateUser(user: User){
        
        
        //check if email already exists in authentication database
        Auth.auth().createUser(withEmail: user.email, password: user.password ) { [self] user, error in
           if let x = error {
              let err = x as NSError
              switch err.code {
              case AuthErrorCode.emailAlreadyInUse.rawValue:
                 print("email is alreay in use")
                 self.emailNotTaken = false
              default:
                 print("unknown error: \(err.localizedDescription)")
              }
              //return
           } else {
              //continue to app
           }
        }
    }
    
    
    func addUser(user: User, accountType: String){
        
        // creating a new document in either student or teacher collection depending on account type chosen
        
        print("is \(accountType)")
        switch accountType {
        case "Student":
            db.collection("Students").document(user.username).setData([
                "country": user.country,
                "date_of_birth": user.dob,
                "email": user.email,
                "firstname" : user.firstName,
                "lastName" : user.lastName,
                "password" : user.password
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Student successfully added!")
                }
            }
        case "Teacher":
            db.collection("Teachers").document(user.username).setData([
                "country": user.country,
                "date_of_birth": user.dob,
                "email": user.email,
                "firstname" : user.firstName,
                "lastName" : user.lastName,
                "password" : user.password
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Teacher successfully added!")
                }
            }
        default:
            print("Error in determining between Teacher and Student account type")
        }
        
        // adding user to the "Users" collection in database
        
        db.collection("Users").document(user.username).setData([
            "password": user.password,
            "user_email": user.email,
            "user_type": accountType
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("User successfully added!")
            }
        }
            

    }
    
    func save(accountType: String){
        authenticateUser(user: newUser)
        
        
        print("User Successfully authenticated, now to add full user info to database.")
        
        print("The email is not taken is : \(emailNotTaken)")
        if(emailNotTaken == true){
            addUser(user: newUser, accountType: accountType)
        }
        else{
            print("email has been taken. Popup informing user will be displaying now.")
        }
        
    }
    
    
}
