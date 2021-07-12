//
//  AnswerCoreData+CoreDataProperties.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//
//

import Foundation
import CoreData


extension AnswerCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerCoreData> {
        return NSFetchRequest<AnswerCoreData>(entityName: "AnswerCoreData")
    }

    @NSManaged public var id: Int16
    @NSManaged public var accuracy: Bool
    @NSManaged public var content: String?
    @NSManaged public var newRelationship: QuestionCoreData?

}

extension AnswerCoreData : DomainConvertible {
    typealias Domain = AnswerModel
    
    var asDomain: AnswerModel {
        var domain = Domain()
        domain.id = Int(self.id)
        domain.content = self.content
        domain.accuracy = self.accuracy
        return domain
    }
}
