//  INFO49635 - CAPSTONE FALL 2022
//  LoginTests.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import XCTest
@testable import Swiftly
@testable import Pods_Swiftly

import FirebaseFirestore

class LoginTests: XCTestCase {
    
    func testInvalidLogin() {
        
        let loginViewModel = LoginViewModel()
        
        let expectation = self.expectation(description: "Login")
        
        loginViewModel.loginUser(email: "", password: "", completion: { _ in
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(loginViewModel.isSuccessful)
    }
    
    func testValidLogin() throws {

        let loginViewModel = LoginViewModel()
        
        let expectation = self.expectation(description: "Login")
        
        loginViewModel.loginUser(email: "moktar@email.com", password: "Moktar11", completion: { _ in
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(loginViewModel.isSuccessful)
    }
}
