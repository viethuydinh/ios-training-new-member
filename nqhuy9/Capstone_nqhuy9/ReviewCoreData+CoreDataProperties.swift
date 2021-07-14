//
//  ReviewCoreData+CoreDataProperties.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//
//

import Foundation
import CoreData


extension ReviewCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewCoreData> {
        return NSFetchRequest<ReviewCoreData>(entityName: "ReviewCoreData")
    }

    @NSManaged public var id: Int16
    @NSManaged public var candidateName: String?
    @NSManaged public var content: String?
    @NSManaged public var status: Bool

}

extension ReviewCoreData : DomainConvert {
    var asDomain: Review {
        Review(id: self.id, candidateName: self.candidateName, content: self.content, status: self.status)
    }
}
