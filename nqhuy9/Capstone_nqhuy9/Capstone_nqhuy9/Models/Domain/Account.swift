//
//  Account.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//

import Foundation
import CoreData

struct Account: Codable {
    var username : String?
    var password : String?
    var repassword : String?
}

extension Account : ObjectConvert {
    var idFirebase: String? {
        get {
            return nil
        }
        set { }
    }
    
    var key: [String : String] {
        return ["username" : self.username ?? ""]
    }
    
    typealias Object = AccountCoreData
    
    func update(object: AccountCoreData?) -> AccountCoreData {
        var value = object
        if value == nil { value = AccountCoreData() }
        value?.username = self.username
        value?.password = self.password
        value?.repassword = self.repassword
        return value!
    }
}
