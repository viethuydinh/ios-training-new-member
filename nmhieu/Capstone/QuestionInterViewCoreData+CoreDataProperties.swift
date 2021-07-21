//
//  QuestionInterViewCoreData+CoreDataProperties.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//
//

import Foundation
import CoreData


extension QuestionInterViewCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionInterViewCoreData> {
        return NSFetchRequest<QuestionInterViewCoreData>(entityName: "QuestionInterViewCoreData")
    }

    @NSManaged public var id: Int16
    @NSManaged public var question: String?
    @NSManaged public var answer: String?
    @NSManaged public var rate: Int16

}

extension QuestionInterViewCoreData : DomainConvertible {
    typealias Domain = QuestionInterviewModel
    
    var asDomain: QuestionInterviewModel {
        var domain = Domain()
        domain.id = Int(self.id)
        domain.question = self.question
        domain.answer = self.answer
        domain.rate = RateAnswer(rawValue: Int(self.rate))
        return domain
    }
}
