//
//  QuestionCoreData+CoreDataProperties.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 21/07/2021.
//
//

import Foundation
import CoreData


extension QuestionCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionCoreData> {
        return NSFetchRequest<QuestionCoreData>(entityName: "QuestionCoreData")
    }

    @NSManaged public var content: String?
    @NSManaged public var id: String?
    @NSManaged public var level: String?
    @NSManaged public var answer: String?

}

extension QuestionCoreData : DomainConvert {
    var asDomain: Question {
        Question(id: self.id, content: self.content, level: self.level,answer: self.answer)
    }
}
