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
    func signIn(account: Account, completion: @escaping((Bool) -> ()))
    
    func signUp(account: Account) -> Bool
}

struct DefaultAuthenticationRepository : AuthenticationRepository {
    
    var accountDAO = CoreDataRepository<Account>.shared
    
    var accountFirebase = FirebaseRepository<Account>.shared
    
    func signIn(account: Account, completion: @escaping((Bool) -> ())) {
        accountFirebase.fetch(tableName: "Account", field: "username", targetCondition: account.username) { acc in
            if acc == nil {
                completion(false)
            } else {
                completion(acc!.username == account.username && acc!.password == account.password)
            }
        }
    }
    
    func signUp(account: Account) -> Bool {
        accountFirebase.save(tableName: "Account", domain: account, id: nil)
    }
}
