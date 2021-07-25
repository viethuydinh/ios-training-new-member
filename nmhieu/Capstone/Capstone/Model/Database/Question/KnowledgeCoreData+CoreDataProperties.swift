//
//  KnowledgeCoreData+CoreDataProperties.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//
//

import Foundation
import CoreData


extension KnowledgeCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KnowledgeCoreData> {
        return NSFetchRequest<KnowledgeCoreData>(entityName: "KnowledgeCoreData")
    }

    @NSManaged public var id: Int16
    @NSManaged public var content: String?
    @NSManaged public var answer: String?
    @NSManaged public var level: Int16

}

extension KnowledgeCoreData : DomainConvertible {
    
    typealias Domain = KnowledgeModel
    
    var asDomain: KnowledgeModel {
        var domain = Domain()
        domain.id = Int(self.id)
        domain.content = self.content
        domain.answer = self.answer
        domain.level = LevelInterView(rawValue: Int(self.level))
        return domain
    }
}
