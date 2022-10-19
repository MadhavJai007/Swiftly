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
        
        var result = ""
        
        let testUser = User(firstName: "",
                                      lastName: "",
                                      username: "",
                                      email: "moktar@email.com",
                                      password: "",
                                      dob : "",
                                      country: "",
                                      classroom: [UserClassroom()])
        
        
        
        print("Testing email status")
        print(testUser.email)
        signupViewModel.checkIfEmailExists(user: testUser) { status in
            switch status {
            case .taken:
                print("taken")
                result = "taken"
            case .free:
                print("free")
                result = "free"
            case .unknown:
                print("unknown")
                result = "unknownn"
            }
        }
        print("Email check should be done now.")
        
        //since email is tied to existing user, result should be "taken"
        XCTAssertEqual(result, "taken")
    }

    func testInvalidSignup() {
        let signupViewModel = SignupViewModel()
        
        //testing isSignupComplete which checks all validation for signup.
        //by default is false since "newUser" variable is set to empty fields until user manually fills in fields
        XCTAssertFalse(signupViewModel.isSignUpComplete)
        

    }
    
    func testValidSignup(){
        let signupViewModel = SignupViewModel()
        
        //calling function that fills in "newUser" with test information, that follows account validation
        signupViewModel.createTestAccount()
        
        //since account information is now meeting all account validation, isSignUpComplete is set to true
        XCTAssertTrue(signupViewModel.isSignUpComplete)
    }
    
}
