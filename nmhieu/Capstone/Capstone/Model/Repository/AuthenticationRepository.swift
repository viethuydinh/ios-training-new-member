//
//  AuthenticationRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 08/07/2021.
//

import Foundation

protocol AuthenticationRepository {
    func signIn(account : AccountModel) -> Bool
    
    func signUp(account : AccountModel) -> Bool
}

struct DefaultAuthenticationRepository : AuthenticationRepository {
    
    var coreDataRepo = CoreDataRepository<AccountModel>.shared
    
    func signIn(account: AccountModel) -> Bool {
        let predicate : NSPredicate = .init(format: "username = %@", argumentArray: [account.username])
        guard let result = self.coreDataRepo.fetch(predicate: predicate) else { return false }
        if result.password == account.password { return true }
        return false
    }
    
    func signUp(account: AccountModel) -> Bool {
        let predicate : NSPredicate = .init(format: "username = %@", argumentArray: [account.username])
        if let result = self.coreDataRepo.fetch(predicate: predicate) { return false }
        else {
            self.coreDataRepo.save(domain: account)
            return true
        }
    }
    
    
}
