//  INFO49635 - CAPSTONE FALL 2022
//  SignupTests.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import XCTest
@testable import Swiftly
@testable import Pods_Swiftly

import Firebase
import FirebaseFirestore

class SignupTests: XCTestCase {

    func testInvalidSignup() {
        
        let signupViewModel = SignupViewModel()
        
        
        //setting newUser signup with empty fields (except for country which is set to 'Canada' by default
        
        signupViewModel.newUser.firstName = ""
        signupViewModel.newUser.lastName = ""
        signupViewModel.newUser.username = ""
        signupViewModel.newUser.email = ""
        signupViewModel.newUser.password = ""
        signupViewModel.newUser.dob = ""
        signupViewModel.newUser.country = "Canada"
        
        //testing isSignupComplete which checks all validation for signup.
        //by default boolean is false since "newUser" variable is set to empty fields until user manually fills in fields
        XCTAssertFalse(signupViewModel.isSignUpComplete)
        

    }
    
    func testValidSignup(){
        let signupViewModel = SignupViewModel()
        
        
        
        //calling function that fills in "newUser" with test information, that follows account validation
        
        //signupViewModel.createTestAccount()
        signupViewModel.newUser.firstName = "testFirstName"
        signupViewModel.newUser.lastName = "testLastName"
        signupViewModel.newUser.username = "testAccount"
        signupViewModel.newUser.email = "testcreateaccount@email.com"
        signupViewModel.newUser.password = "Password12"
        signupViewModel.newUser.dob = "01/01/2000"
        signupViewModel.newUser.country = "Canada"
        
        //since account information is now meeting all account validation, isSignUpComplete is set to true
        XCTAssertTrue(signupViewModel.isSignUpComplete)
    }
    
}
