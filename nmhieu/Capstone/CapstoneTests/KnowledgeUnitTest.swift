//
//  KnowledgeUnitTest.swift
//  CapstoneTests
//
//  Created by Nguyễn Minh Hiếu on 04/08/2021.
//

import XCTest
@testable import Capstone

class KnowledgeUnitTest: XCTestCase {
    
    @Inject var knowledgeVM : KnowledgeViewModel
    
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func fetchKnowledgeFirebase() {
        self.knowledgeVM.fetchKnowledge(level: .fresher) { response, error in
            XCTAssert(response.count > 0 , error.debugDescription)
        }
    }
    
    func updateKnowledgeFiebase() {
        self.knowledgeVM.updateKnowledge(knowledge: KnowledgeModel()) { error in
            XCTAssert(true, error.debugDescription)
        }
    }
    
}
