//
//  AccountCoreData+CoreDataProperties.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//
//

import Foundation
import CoreData


extension AccountCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCoreData> {
        return NSFetchRequest<AccountCoreData>(entityName: "AccountCoreData")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var repassword: String?

}

extension AccountCoreData : Identifiable {

}

extension AccountCoreData: DomainConvertable {
    var asDomain: Account {
        return Account()
    }
}

extension AccountCoreData: ObjectConvertable {
    func update(object: AccountCoreData) -> AccountCoreData {
        
    }
}
