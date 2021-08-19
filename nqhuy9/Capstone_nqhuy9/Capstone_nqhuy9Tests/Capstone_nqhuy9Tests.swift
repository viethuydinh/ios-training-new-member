//
//  Capstone_nqhuy9Tests.swift
//  Capstone_nqhuy9Tests
//
//  Created by Nghiêm Huy on 7/2/21.
//

import XCTest
@testable import Capstone_nqhuy9

class Capstone_nqhuy9Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    //MARK: -Test Authentication
    func testSignUp() {
        let acc = Account(username: "huy@gmail.com", password: "Huy123!", repassword: "Huy123!")
        let authen = DefaultAuthenticationViewModel()
        XCTAssert(authen.signUp(account: acc))
    }
    
    func testValidateEmail() {
        let acc = Account(username: "huy@gmail", password: "Huy123!", repassword: "Huy123!")
        let authen = DefaultAuthenticationViewModel()
        XCTAssert(authen.emailValidate(email: acc.username))
    }
    
    func testValidatePassword() {
        let acc = Account(username: "huy@gmail.com", password: "Huy123", repassword: "Huy123!")
        let authen = DefaultAuthenticationViewModel()
        XCTAssert(authen.passwordValidate(password: acc.password))
    }
    
    func testValidateRepassword() {
        let acc = Account(username: "huy@gmail.com", password: "Huy123!", repassword: "Huy12!")
        let authen = DefaultAuthenticationViewModel()
        XCTAssert(authen.repasswordValidate(password: acc.password, repassword: acc.repassword))
    }

}
