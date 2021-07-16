//
//  InterviewCoreData+CoreDataProperties.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//
//

import Foundation
import CoreData
import UIKit

extension InterviewCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InterviewCoreData> {
        return NSFetchRequest<InterviewCoreData>(entityName: "InterviewCoreData")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var image: String?
    @NSManaged public var jobTitle: String?
    @NSManaged public var level: Int16
    @NSManaged public var overviewContent: String?
    @NSManaged public var result: Int16
    @NSManaged public var date : Date
}

extension InterviewCoreData : DomainConvertible{
    
    typealias Domain = InterviewModel
    
    var asDomain: InterviewModel {
        var domain = Domain()
        domain.id = Int(self.id)
        var candidateInfor = CandidateInforModel()
        candidateInfor.name = self.name
        candidateInfor.age = Int(self.age)
        candidateInfor.image = UIImage(data: Data(base64Encoded: self.image ?? "" ) ?? Data())
        candidateInfor.level = LevelInterView(rawValue: Int(self.level))
        candidateInfor.jobTitle = self.jobTitle 
        domain.candidateInfor = candidateInfor
        var overview = OverviewModel()
        overview.content = self.overviewContent
        overview.status = StatusInterview(rawValue: Int(self.result))
        domain.overview = overview 
        domain.date = self.date
        return domain
        
    }
}
