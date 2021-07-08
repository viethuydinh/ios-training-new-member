//
//  AuthenticationRepository.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol AuthenticationRepository {
    func signIn(account: Account) -> Bool
    
    func signUp(account: Account)
}

struct DefaultAuthenticationRepository : AuthenticationRepository {
    
    var accountDAO = CoreDataRepository<Account>.shared
    
    func signIn(account: Account) -> Bool {
        guard let username = account.username else { return false }
        guard let password = account.password else { return false }
        guard let result = accountDAO.fetch(predicate: .init(format: "username = %@", argumentArray: [username])) else { return false }
        if username == result.username && password == result.password {
            return true
        } else {
            return false
        }
    }
    
    func signUp(account: Account) {
        accountDAO.save(domain: account)
    }
}
