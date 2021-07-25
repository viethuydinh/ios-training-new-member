//
//  AuthenticationError.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 16/07/2021.
//

import Foundation

enum AuthenticationError : String {
    
    case emptyField = "All fields are mandatory"
    case inforNotfound = "Username or password is invalid"
    case confirmPasswordNotMatch = "The password does not match"
    case notAvailableUsername = "This username not available"
}
