//  INFO49635 - CAPSTONE FALL 2022
//  EditAccountTests.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import XCTest
@testable import Swiftly
@testable import Pods_Swiftly

import Firebase
import FirebaseFirestore

class EditAccountTests: XCTestCase {

    func testInvalidAccountEdit(){
        let userAccountViewModel = UserAccountViewModel()
        
        
        //creating test user for filling in logged in data used for updating account information
        userAccountViewModel.createTestLoggedInUser()
        
        
        //all the edit fields are empty, failing every validation teste, making editing NOT complete,therefore false on boolean check
        XCTAssertFalse(userAccountViewModel.isEditingComplete)
        
        
    }
    
    func testValidAccountEdit(){
        let userAccountViewModel = UserAccountViewModel()
        
        
        //creating test user for filling in logged in data used for updating account information
        userAccountViewModel.createTestLoggedInUser()
        
        //performing test edit where fields are updated to make changes to users account
        userAccountViewModel.createTestEdit()
        
        
        //since all fields are filled in and meet validation requirements, editing is complete, therefore true on boolean check
        XCTAssertTrue(userAccountViewModel.isEditingComplete)
        
        
    }

}
