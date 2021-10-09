//  INFO49635 - CAPSTONE FALL 2021
//  SignupViewModel.swift
//  Swiftly

import Foundation
import SwiftUI
import Firebase

final class SignupViewModel: ObservableObject {
    
    
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
