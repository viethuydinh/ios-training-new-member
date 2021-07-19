//
//  Authentication+CoreDataProperties.swift
//  CapstoneProject
//
//  Created by Thuy on 7/16/21.
//
//

import Foundation
import CoreData


extension Authentication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Authentication> {
        return NSFetchRequest<Authentication>(entityName: "Authentication")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var confirmPassword: String?

}

extension Authentication : Identifiable {

}
