//
//  AuthenticationUnitTest.swift
//  CapstoneTests
//
//  Created by Nguyễn Minh Hiếu on 02/08/2021.
//
@testable import Capstone
import XCTest

class AuthenticationUnitTest: XCTestCase {

    @Inject var authenticationVM : AuthenticationViewModel
    
    func testSignIn() throws {
        let authentSignIn = self.authenticationVM.signIn(username: "2", password: "2")
        XCTAssert(authentSignIn.state,authentSignIn.message)
    }
    
    func testSignUp() throws{
        let authent = self.authenticationVM.signUp(username: "2", password: "2", repassword: "2")
        XCTAssert(authent.state, authent.message)
    }
    
    func testSignInFirebase() {
        self.authenticationVM.signIn(username: "nguyenminhhieu@gmail.com", password: "123456") { state, error in
            XCTAssert(state, error)
        }
    }
    
    func testSignUpFirebase() {
        self.authenticationVM.signUp(username: "", password: "", repassword: "") { state, error in
            XCTAssert(state, error)
        }
    }

}
