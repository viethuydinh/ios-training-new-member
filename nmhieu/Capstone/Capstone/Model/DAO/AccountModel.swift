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
    typealias Object = AccountCoreData

    func update(obj: AccountCoreData) -> AccountCoreData {
        let object = obj
        object.username = self.username
        object.password = self.password
        object.email = self.email
        return object
    }
}
