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
    func signIn(account: Account) -> Observable<()>
    
    func signUp(account: Account) -> Observable<()>
}

struct DefaultAuthenticationRepository : AuthenticationRepository {
    
    func signIn(account: Account) -> Observable<()> {
        return .empty()
    }
    
    func signUp(account: Account) -> Observable<()> {
        return .empty()
    }
}
