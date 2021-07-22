//
//  AuthenticationViewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 08/07/2021.
//

import Foundation

protocol AuthenticationViewModel {
    func signIn(username : String, password : String) -> (state : Bool,message : String)
    
    func signUp(username : String, password : String, repassword : String) -> (state : Bool,message : String)
}

struct DefaultAuthenticationViewModel : AuthenticationViewModel {
    
    var authenticationRepo = DefaultAuthenticationRepository()
    
    func signIn(username: String, password: String) -> (state : Bool, message : String) {
        if username.isEmpty || password.isEmpty {
            return (false, AuthenticationError.emptyField.rawValue)
        }
        else {
            var account = AccountModel()
            account.username = username
            account.password = password
            account.email = username
            let state = self.authenticationRepo.signIn(account: account)
            let message = state ? ("") : (AuthenticationError.inforNotfound.rawValue)
            return (state, message)
        }
    }

    func signUp(username: String, password: String, repassword: String) -> (state : Bool,message : String) {
        if username.isEmpty || password.isEmpty || repassword.isEmpty {
            return (false ,AuthenticationError.emptyField.rawValue)
        }
        else if password != repassword {
            return (false ,AuthenticationError.confirmPasswordNotMatch.rawValue)
        }
        else {
            var account = AccountModel()
            account.username = username
            account.password = password
            account.email = username
            let state = self.authenticationRepo.signUp(account: account)
            let message = state ? ("") : (AuthenticationError.notAvailableUsername.rawValue)
            return (state ,message)
        }
    }
    
    func saveSecretAccout(username : String, password : String) {
        
    }
}
