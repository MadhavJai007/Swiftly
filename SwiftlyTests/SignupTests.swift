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

    func testOverlappingEmailSignup() {
        let signupViewModel = SignupViewModel()
        
        signupViewModel.newUser.firstName = "test"
        signupViewModel.newUser.lastName = "test"
        signupViewModel.newUser.username = "testAccount"
        signupViewModel.newUser.email = "testcreateaccount@email.com"
        signupViewModel.newUser.password = "Password12"
        signupViewModel.newUser.dob = "25/02/2000"
        signupViewModel.newUser.country = "Canada"
        
        print("now testing email overlap")
        signupViewModel.testEmailOverlap()
        
        //since email is tied to existing user, result should be "taken"
        XCTAssertEqual(signupViewModel.result, "taken")
    }

    func testInvalidSignup() {
        
        let signupViewModel = SignupViewModel()
        
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
        signupViewModel.newUser.firstName = "test"
        signupViewModel.newUser.lastName = "test"
        signupViewModel.newUser.username = "testAccount"
        signupViewModel.newUser.email = "testcreateaccount@email.com"
        signupViewModel.newUser.password = "Password12"
        signupViewModel.newUser.dob = "25/02/2000"
        signupViewModel.newUser.country = "Canada"
        
        //since account information is now meeting all account validation, isSignUpComplete is set to true
        XCTAssertTrue(signupViewModel.isSignUpComplete)
    }
    
}
