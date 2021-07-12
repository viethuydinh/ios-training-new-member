//
//  AnswerCoreData+CoreDataProperties.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//
//

import Foundation
import CoreData


extension AnswerCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerCoreData> {
        return NSFetchRequest<AnswerCoreData>(entityName: "AnswerCoreData")
    }

    @NSManaged public var accuracy: Bool
    @NSManaged public var content: String?
    @NSManaged public var id: Int16

}

extension AnswerCoreData : Identifiable {

}

extension AnswerCoreData : DomainConvert {
    var asDomain: Answer {
        Answer(id: self.id, content: self.content, accuracy: self.accuracy)
    }
}
