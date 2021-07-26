//
//  AuthenticationViewModels.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/8/21.
//

import Foundation

protocol AuthenticationViewModels {
    func signIn(account: Account) -> Bool
    
    func signUp(account: Account) -> Bool
    
    func emailValidate(email: String?) -> Bool
    
    func passwordValidate(password: String?) -> Bool
}

struct DefaultAuthenticationViewModel: AuthenticationViewModels {
    
    var repository : DefaultAuthenticationRepository
    
    init() {
        self.repository = DefaultAuthenticationRepository()
    }
    
    func signIn(account: Account) -> Bool {
        if self.emailValidate(email: account.username) && self.passwordValidate(password: account.password) {
            return repository.signIn(account: account)
        } else {
            return false
        }
    }
    
    func signUp(account: Account) -> Bool {
        if self.emailValidate(email: account.username) && self.passwordValidate(password: account.password) && self.repasswordValidate(password: account.password, repassword: account.repassword) {
            return repository.signUp(account: account)
        } else {
            return false
        }
    }
    
    func emailValidate(email: String?) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    func passwordValidate(password: String?) -> Bool {
        //Password must be more than 6 characters, with at least one capital, numeric or special character
        let passwordRegex = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"

        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
    
    func repasswordValidate(password: String?, repassword: String?) -> Bool {
        return password == repassword
    }
}
