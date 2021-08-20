//
//  AuthenticationRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 08/07/2021.
//

import Foundation

protocol AuthenticationRepository {
    func signIn(account : AccountModel) -> Bool
    
    func signIn(account : AccountModel, completion : @escaping (Error?) -> ())
    
    func signUp(account : AccountModel) -> Bool
    
    func signUp(account : AccountModel, completion : @escaping (Error?) -> ())
}

struct DefaultAuthenticationRepository : AuthenticationRepository {
    
    var coreDataRepo = CoreDataRepository<AccountModel>.shared
    
    var firebaseRepo = DefaultAuthenticationFirebase.shared
    
    func signIn(account: AccountModel) -> Bool {
        let predicate : NSPredicate = .init(format: "username = %@", argumentArray: [account.username])
        guard let result = self.coreDataRepo.fetch(predicate: predicate) else { return false }
        if result.password == account.password { return true }
        return false
    }
    
    func signIn(account: AccountModel, completion: @escaping (Error?) -> ()) {
        guard let email = account.username ,let password = account.password else { return }
        self.firebaseRepo.signIn(email: email, password: password) { error in
            completion(error)
        }
    }
    
    func signUp(account: AccountModel) -> Bool {
        let predicate : NSPredicate = .init(format: "username = %@", argumentArray: [account.username])
        if self.coreDataRepo.fetch(predicate: predicate) != nil { return false }
        else {
            self.coreDataRepo.save(domain: account)
            return true
        }
    }
    
    func signUp(account: AccountModel, completion: @escaping (Error?) -> ()) {
        guard let email = account.username ,let password = account.password else { return }
        self.firebaseRepo.createUser(email: email, password: password) { error in
            completion(error)
        }
    }
}
