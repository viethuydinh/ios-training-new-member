//
//  QuestionCoreData+CoreDataProperties.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//
//

import Foundation
import CoreData


extension QuestionCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionCoreData> {
        return NSFetchRequest<QuestionCoreData>(entityName: "QuestionCoreData")
    }

    @NSManaged public var id: Int16
    @NSManaged public var content: String?
    @NSManaged public var level: Int16

}

extension QuestionCoreData : DomainConvertible {
    typealias Domain = QuestionModel
    
    var asDomain: QuestionModel {
        var domain = Domain()
        domain.id = Int(self.id)
        domain.content = self.content
        domain.level = LevelInterView(rawValue: Int(self.level))
        return domain
    }
}
