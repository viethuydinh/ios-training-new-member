//
//  AccountCoreData+CoreDataProperties.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/8/21.
//
//

import Foundation
import CoreData


extension AccountCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCoreData> {
        return NSFetchRequest<AccountCoreData>(entityName: "AccountCoreData")
    }

    @NSManaged public var password: String?
    @NSManaged public var repassword: String?
    @NSManaged public var username: String?

}

extension AccountCoreData : DomainConvert {
    var asDomain: Account {
        Account(username: self.username, password: self.password, repassword: self.repassword)
    }
}
