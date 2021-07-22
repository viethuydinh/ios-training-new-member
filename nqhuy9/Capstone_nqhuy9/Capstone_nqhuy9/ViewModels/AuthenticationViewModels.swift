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
}

struct DefaultAuthenticationViewModel: AuthenticationViewModels {
    
    var repository : DefaultAuthenticationRepository
    
    init() {
        self.repository = DefaultAuthenticationRepository()
    }
    
    func signIn(account: Account) -> Bool {
        return repository.signIn(account: account)
    }
    
    func signUp(account: Account) -> Bool {
        repository.signUp(account: account)
    }
}
