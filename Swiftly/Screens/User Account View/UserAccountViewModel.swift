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
                       country: "",
                       classroom: [UserClassroom()])
    
    @Published var classroomName = ""
    
    @Published var isUserInfoRetrieved = false
    
    @Published var userChapterCompletionCount = 0
    @Published var userChapterInProgressCount = 0
    
    @Published var userTotalScore = 0
    @Published var userTotalPossibleScore = 0
    @Published var userQuestionCompleteCount = 0
    
    var loggedInAccountType : String = ""
    
    
    @Published var updatedUser = User(firstName: "",
                       lastName: "",
                       username: "",
                       email: "",
                       password: "",
                       dob : "",
                       country: "",
                       classroom: [UserClassroom()]
                    )
    
    
    
    //validation methods for updating account
    
    
    func isDateValid() -> Bool{
        
        //must be in dd/mm/yyyy format, only numerics
        
        let dateTest = NSPredicate(format: "SELF MATCHES %@", "^\\d{2}\\/\\d{2}\\/\\d{4}$")
        return dateTest.evaluate(with: updatedUser.dob)
    }
    
    
    func isPasswordValid() -> Bool{
        
        //Password must be at least 8 characters, no more than 15 characters, and must include at least one upper case letter, one lower case letter, and one numeric digit.
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=[^\\d_].*?\\d)\\w(\\w|[!@#$%]){7,20}")
        return passwordTest.evaluate(with: updatedUser.password)
    }
    
    func isUserNameValid() -> Bool{
        return updatedUser.username != ""
    }
    
    func isFirstNameValid() -> Bool{
        return updatedUser.firstName != ""
    }
    
    func isLastNameValid() -> Bool{
        return updatedUser.lastName != ""
    }
    
    func isCountryValid() -> Bool{
        return updatedUser.country != ""
    }
    
    
    var isEditingComplete : Bool {
        
        if !isPasswordValid(){
            return false
        }
        
        if !isDateValid(){
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
    
    
    //function for passing currently logged in users info into another User variable to be used for updating account info
    
    func retrieveAccountinfo(){
        updatedUser.firstName = loggedInUser.firstName
        updatedUser.lastName = loggedInUser.lastName
        updatedUser.username = loggedInUser.username
        updatedUser.email = loggedInUser.email
        updatedUser.password = loggedInUser.password
        updatedUser.dob = loggedInUser.dob
        updatedUser.country = loggedInUser.country
    }
    
    func clearStats(){
        userChapterCompletionCount = 0
        userChapterInProgressCount = 0
        userTotalScore = 0
        userQuestionCompleteCount = 0
    }
    
    func getUserStats(){
        
        for i in 0..<loggedInUser.classroom[0].chapterProgress.count{
            
            if (loggedInUser.classroom[0].chapterProgress[i].chapterStatus == "complete"){
                userChapterCompletionCount += 1
            }
            
            else if (loggedInUser.classroom[0].chapterProgress[i].chapterStatus == "inprogress"){
                userChapterInProgressCount += 1
            }
            
            
            for k in 0..<loggedInUser.classroom[0].chapterProgress[i].questionScores.count{
                userTotalScore += loggedInUser.classroom[0].chapterProgress[i].questionScores[k]
                
                if (loggedInUser.classroom[0].chapterProgress[i].questionProgress[k] == "complete"){
                    userQuestionCompleteCount += 1
                }
            }
            
            
            
        }
        
        
    }
    
    func updateAccount(){
        
        print("Logged In: \(loggedInUser)")
        print("Updated: \(updatedUser)")
        
        //first update the firebase authentication with new information (password specifically)
        
        let user = Auth.auth().currentUser
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: loggedInUser.email, password: loggedInUser.password)

        
        
        user?.reauthenticate(with: credential, completion: {(authResult, error) in
                    if error != nil {
                        print("Error: \(String(describing: error))")
                    }else{
                        print("Successfully Reauthenticated! ")
                    }
                })
        
        Auth.auth().currentUser?.updatePassword(to: updatedUser.password) { (error) in
          print("Successfully updated password!")
        }
        
        
        let updatingRef = db.collection("Students").document(loggedInUser.username)

        updatingRef.updateData([
            "country": updatedUser.country,
            "date_of_birth": updatedUser.dob,
            "firstname" : updatedUser.firstName,
            "lastName" : updatedUser.lastName,
            "password" : updatedUser.password,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                
                self.loggedInUser.firstName = self.updatedUser.firstName
                self.loggedInUser.lastName = self.updatedUser.lastName
                self.loggedInUser.username = self.updatedUser.username
                self.loggedInUser.email = self.updatedUser.email
                self.loggedInUser.password = self.updatedUser.password
                self.loggedInUser.dob = self.updatedUser.dob
                self.loggedInUser.country = self.updatedUser.country
        
            }
        }
    }
    

    /// Function to logout the user
    func logoutUser(){
        do {
            try Auth.auth().signOut()
            self.isUserInfoRetrieved = false
            logoutSuccessful = true
            loggedInAccountType = ""
            loggedInUser = User(firstName: "",
                                lastName: "",
                                username: "",
                                email: "",
                                password: "",
                                dob : "",
                                country: "",
                                classroom: [UserClassroom()]
                             )
            self.userTotalScore = 0
            self.userQuestionCompleteCount = 0
            self.userTotalPossibleScore = 0
            self.userChapterInProgressCount = 0
            self.userChapterCompletionCount = 0
            
        }
        catch {
            print("already logged out")
            logoutSuccessful = false
        }
    }
}
