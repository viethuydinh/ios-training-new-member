//
//  AuthenticationViewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 08/07/2021.
//

import Foundation

protocol AuthenticationViewModel {
    func signIn(username : String, password : String) -> Bool
    
    func signUp(username : String, password : String, repassword : String) -> Bool
}

struct DefaultAuthenticationViewModel : AuthenticationViewModel {
    
    var authenticationRepo = DefaultAuthenticationRepository()
    
    func signIn(username: String, password: String) -> Bool {
        if username.isEmpty || password.isEmpty {
            return false
        }
        else {
            var account = AccountModel()
            account.username = username
            account.password = password
            account.email = username
            return self.authenticationRepo.signIn(account: account) ?? false
        }
    }

    func signUp(username: String, password: String, repassword: String) -> Bool {
        if username.isEmpty || password.isEmpty || repassword.isEmpty {
            return false
        }
        else if password != repassword {
            return false
        }
        else {
            var account = AccountModel()
            account.username = username
            account.password = password
            account.email = username
            return self.authenticationRepo.signUp(account: account) ?? false
        }
    }
    
    func saveSecretAccout(username : String, password : String) {
        
    }
}
