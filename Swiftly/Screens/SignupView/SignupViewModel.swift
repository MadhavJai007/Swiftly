//  INFO49635 - CAPSTONE FALL 2021
//  SignupViewModel.swift
//  Swiftly

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

final class SignupViewModel: ObservableObject {
    
    
    init(){
        //initializer
    }
    
    
    @Published var newUser = User(firstName: "",
                       lastName: "",
                       username: "",
                       email: "",
                       password: "",
                       dob: "",
                       country: ""
                    )
    
    @Published var isBadSignup: Bool = false
    
    private var db = Firestore.firestore()
    
    //boolean to ensure that email being used has not already been registered with Swiftly
    var emailNotTaken = false
    
    
    
    //Validation functions
    
    func isEmailValid() -> Bool{
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: newUser.email)
    }
    
    func isUserNameValid() -> Bool{
        return newUser.username != ""
    }
    
    func isFirstNameValid() -> Bool{
        return newUser.firstName != ""
    }
    
    func isLastNameValid() -> Bool{
        return newUser.lastName != ""
    }
    
    func isCountryValid() -> Bool{
        return newUser.country != ""
    }
    
    
    var isSignUpComplete : Bool {
        if !isEmailValid(){
            return false
        }
        if !isUserNameValid(){
            return false
        }
        if !isFirstNameValid(){
            return false
        }
        if !isLastNameValid(){
            return false
        }
        if !isCountryValid(){
            return false
        }
        return true
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
       
    }
    
    //adding user data to authentication database and Students/Teachers/Experts and Users firestore collections
    
    func authenticateUser(user: User){
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [self] user, error in
            print("Created authentication account successfully")
        }
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
        

        //Current solution to async is to put hardcoded timers between authenticateUser() and addUser(), so that they only executes AFTER the email check
        
        
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [self] (timer) in
            
            print("The email is not taken is : \(emailNotTaken)")
            if(emailNotTaken == false){
                self.isBadSignup = true
            }
            
        }
        
        let timer2 = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { [self] (timer) in
            
            print("The email is not taken is : \(emailNotTaken)")
            if(emailNotTaken == true){
                print("Since the email was valid, now execute authenticateUser() to add user to authenticator")
                self.authenticateUser(user: newUser)
            }
            else{
                self.isBadSignup = true
            }
            
        }
        
        let timer3 = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [self] (timer) in
            if(emailNotTaken == true){
                print("Finally, since the email was valid, now execute addUser() to add user to collections")
                self.addUser(user: newUser, accountType: accountType)
            }
            
        }
        
    }
    
    
}
