//
//  UserCoreData+CoreDataProperties.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 06/07/2021.
//
//

import Foundation
import CoreData


extension UserCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreData> {
        return NSFetchRequest<UserCoreData>(entityName: "UserCoreData")
    }

    @NSManaged public var image: String?
    @NSManaged public var email: String?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var sex: Int16
    @NSManaged public var username: String?
    @NSManaged public var id: Int16
    @NSManaged public var position: String?
    @NSManaged public var descript: String?
}

extension UserCoreData : Identifiable {

}

