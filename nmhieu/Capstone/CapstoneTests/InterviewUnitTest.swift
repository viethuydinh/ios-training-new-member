//
//  InterviewUnitTest.swift
//  CapstoneTests
//
//  Created by Nguyễn Minh Hiếu on 10/08/2021.
//

import XCTest
@testable import Capstone

class InterviewUnitTest: XCTestCase {

    @Inject var interviewVM : InterviewViewModel
    
    func testFetchHistory() {
        let fetchHistory = self.interviewVM.fetchInterviewHistory()
        XCTAssertEqual(fetchHistory.isEmpty , true)
    }
    
    func testSaveInterviewFirebase() {
        
    }

}
