//
//  QuestionCoreData+CoreDataProperties.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//
//

import Foundation
import CoreData


extension QuestionCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionCoreData> {
        return NSFetchRequest<QuestionCoreData>(entityName: "QuestionCoreData")
    }

    @NSManaged public var content: String?
    @NSManaged public var id: Int16
    @NSManaged public var level: String?

}

extension QuestionCoreData : Identifiable {

}

extension QuestionCoreData : DomainConvert {
    var asDomain: Question {
        Question(id: self.id, content: self.content, level: self.level)
    }
}
