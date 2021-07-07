//
//  AccountCoreData+CoreDataProperties.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 07/07/2021.
//
//

import Foundation
import CoreData


extension AccountCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCoreData> {
        return NSFetchRequest<AccountCoreData>(entityName: "AccountCoreData")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension AccountCoreData : DomainConvertible {
    typealias Domain = AccountModel
    
    var asDomain: Domain {
        var domain = Domain()
        domain.username = self.username
        domain.password = self.password
        domain.email = self.email
        return domain
    }
}
