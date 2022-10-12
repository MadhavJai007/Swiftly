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
        
        loginViewModel.loginUser(email: "swiftlytest@email.com", password: "Test1234", completion: { _ in
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(loginViewModel.isSuccessful)
    }
    
    func testChaptersDownload() throws {
        let chaptersViewModel = ChaptersViewModel()
        let expectation = self.expectation(description: "Download")
        var chapterDownloadStatus: DownloadStatus?
        
        chaptersViewModel.downloadChapters(completion: { status in
            chapterDownloadStatus = status
            expectation.fulfill()
        })
                              
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(chapterDownloadStatus)
        XCTAssertEqual(chapterDownloadStatus, .success)
   }
    
    func testUserProgressDownload() throws {
        let loginViewModel = LoginViewModel()
        let chaptersViewModel = ChaptersViewModel()
        
        chaptersViewModel.chaptersArr.removeAll()
        chaptersViewModel.clearAllData()
        
        let expectation = self.expectation(description: "UserProgress")
        expectation.assertForOverFulfill = false
        
        chaptersViewModel.downloadChapters { _ in
            chaptersViewModel.organizeChaptersByNumber {
                chaptersViewModel.retrieveUserbaseCompletion { _ in
                    loginViewModel.loginUser(email: "swiftlytest@email.com", password: "Test1234") { _ in
                        chaptersViewModel.startUserDownload(email: "swiftlytest@email.com") { status in
                            switch status {
                            case .success:
                                chaptersViewModel.isUserLoggedIn = true
                            case .failure:
                                print("Something went wrong...")
                            }
                            expectation.fulfill()
                        }
                    }
                }
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(chaptersViewModel.isUserLoggedIn, true)
    }
}
