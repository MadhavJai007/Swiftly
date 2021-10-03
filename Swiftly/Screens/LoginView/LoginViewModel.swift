//  INFO49635 - CAPSTONE FALL 2021
//  LoginViewModel.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-30.

import Foundation
import SwiftUI
import Firebase

final class LoginViewModel: ObservableObject {
    
    @Published var isSuccessful: Bool
    @Published var isBadLogin: Bool
    
    init(){
        isSuccessful = false
        isBadLogin = false
    }
    
    func login(email: String, password: String){
        
        Auth.auth().signIn(withEmail: "test@email.com", password: "123456") { result, error in
            
            if error != nil {
                print("Bad Login")
                self.isSuccessful = false
                self.isBadLogin = true
            }else{
                
                print("Succesful login")
                self.isSuccessful = true
                self.isBadLogin = false
            }
        }
    }
}
