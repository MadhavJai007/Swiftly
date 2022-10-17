//  INFO49635 - CAPSTONE FALL 2022
//  ChaptersTests.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import XCTest
@testable import Swiftly
@testable import Pods_Swiftly

class ChaptersTests: XCTestCase {
    
    // Testing: Downloading Swiftly chapters
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
    
    
    // Add test for getting userbase completion

}

