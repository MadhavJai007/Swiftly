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
    var emailNotTaken = false
    
    func authenticateUser(user: User){
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [self] user, error in
            
            print("Created authentication account successfully")
        }
    }
    
    func checkIfEmailExists(user: User){
        print("Email to be checked if it exists in Users collection is : \(user.email)")
        
        
        // Get your Firebase collection
           let collectionRef = db.collection("Users")

           // Get all the documents where the field username is equal to the String you pass, loop over all the documents.

        collectionRef.whereField("user_email", isEqualTo: user.email).getDocuments { (snapshot, err) in
               if let err = err {
                   print("Error getting document: \(err)")
               } else if (snapshot?.isEmpty)! {
                   print("Email is not taken. It is valid.")
                   self.emailNotTaken = true
               } else {
                   for document in (snapshot?.documents)! {
                       if document.data()["username"] != nil {
                           print("Email is Taken. It is NOT valid.")
                           self.emailNotTaken = false
                       }
                   }
               }
           }
        
        /*
        db.collection("Users").whereField("user_email", isEqualTo: user.email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Email already exist in database. It is NOT valid")
                self.emailNotTaken = false
            } else {
                print("Email is not taken. It is valid.")
                self.emailNotTaken = true
            }
        }
         */
        
        
    }
    
    
    func addUser(user: User, accountType: String){
        
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
        
        emailNotTaken = false
        
        print("First we will check if the email already exists in our database using checkIfEmailExists().")
        checkIfEmailExists(user: newUser)

        //Current solution to async is to put hardcoded 5 second timers between authenticateUser() and addUser(), so that they only execute AFTER the email check
        
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [self] (timer) in
            
            print("The email is not taken is : \(emailNotTaken)")
            if(emailNotTaken == true){
                print("Since the email was valid, now execute authenticateUser() to add user to authenticator")
                self.authenticateUser(user: newUser)
            }
            
        }
        
        let timer2 = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [self] (timer) in
            if(emailNotTaken == true){
                print("Finally, since the email was valid, now execute addUser() to add user to collections")
                self.addUser(user: newUser, accountType: accountType)
            }
            
        }
        
    }
    
    
}
