//
//  Entity+CoreDataProperties.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//
//

import Foundation
import CoreData

extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var email: String?

}

extension Entity : Identifiable {

}
