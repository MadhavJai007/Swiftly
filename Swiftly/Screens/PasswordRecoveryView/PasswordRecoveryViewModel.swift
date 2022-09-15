//
//  PasswordRecoveryViewModel.swift
//  Swiftly
//
//  Created by Arjun Suthaharan on 2022-09-10.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


final class PasswordRecoveryViewModel: ObservableObject {
    
    init(){
        //initializer
    }
    
    
    //published variables
    @Published var toggleNow: Bool = false
    @Published var email: String = ""
    
    //boolean to ensure the email being used to reset password exists
    @Published var emailExists: Bool = false
    
    //db variable for firestore information
    private var db = Firestore.firestore()
    
    
    
    func isEmailValid() -> Bool{
        
        ///email input must be in email@email.com format
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    
    func checkIfEmailExists(emailChecked: String){
        print("Email to be checked if it exists in Users collection is : \(emailChecked)")
        
        let emailCompared = emailChecked
        
        //        print("After lowercased its : \(emailCompared)")
        //
        //        switch accountType {
        //        case "Student":
        //            print("search student collection")
        //            let collectionRef = db.collection("Students")
        //
        //        case "Teacher":
        //            print("search teacher collection")
        //            let collectionRef = db.collection("Teachers")
        //        default:
        //            print("there is no default case")
        //
        //        }
        /// retrieving  Firebase collection
        let collectionRef = db.collection("Students")
        
        /// getting all the documents where the field username is equal to the String you pass, loop over all the documents.
        
        collectionRef.whereField("email", isEqualTo: emailCompared).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else if (snapshot?.isEmpty)! {
                print("Email does NOT exist.")
                self.emailExists = false
            } else {
                for document in (snapshot?.documents)! {
                    if document.data()["username"] != nil {
                        print("Email DOES exist.")
                        self.emailExists = true
                        
                    }
                }
            }
        }
        
    }
    
    func resetPassword(){
        checkIfEmailExists(emailChecked: email)
        
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if(!self.emailExists){
                print("Email does not exist, not sending reset")
                return
            }
            else{
                print("Email sent successfully")
            }
            
        }
    }
    
}
