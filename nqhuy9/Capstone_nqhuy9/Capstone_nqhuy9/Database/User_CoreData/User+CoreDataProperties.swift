//
//  User+CoreDataProperties.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var date_of_birth: String?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var major: String?

}

extension User_CoreData: DomainConvertable {
    var asDomain: User {
        return User()
    }
}

extension User: ObjectConvertable {
    func update(object: User_CoreData) -> User_CoreData {
        
    }
}


