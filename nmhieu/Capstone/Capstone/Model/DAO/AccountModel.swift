//
//  AccountModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 07/07/2021.
//

import Foundation

struct AccountModel {
    var username : String?
    var password : String?
    var email : String?
}

extension AccountModel : ObjectConvertible {
    var primaryKey : [String : String] {
        return ["username":self.username!]
    }
    
    typealias Object = AccountCoreData

    var asObject: AccountCoreData {
        var object = AccountCoreData()
        object.username = self.username
        object.password = self.password
        object.email = self.email
        return object
    }
    
    func update(obj: AccountCoreData) -> AccountCoreData {
        var object = obj
        object.username = self.username
        object.password = self.password
        object.email = self.email
        return object
    }
}
