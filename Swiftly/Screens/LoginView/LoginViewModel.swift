//
//  LoginViewModel.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-30.
//

import Foundation
import SwiftUI
import Firebase

final class LoginViewModel: ObservableObject {
    
    @Published var isSuccessful: Bool
    
    init(){
        isSuccessful = false
    }
    
    func login(email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                print("Bad Login")
                self.isSuccessful = false
            }else{
                
                print("Succesful login")
                self.isSuccessful = true
            }
        }
    }
}
