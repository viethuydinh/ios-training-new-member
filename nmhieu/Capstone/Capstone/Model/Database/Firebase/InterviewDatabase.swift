//
//  InterviewDatabase.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 16/08/2021.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

struct InterviewDatabase : Codable {
    @DocumentID var id: String?
    var name: String?
    var age: Int?
    var image: String?
    var jobTitle: String?
    var level: Int?
    var overviewContent: String?
    var result: Int?
    var date : Date?
}

extension InterviewDatabase : DomainConvertibleFirebase {
    
    typealias DomainFirebase = InterviewModel
    
    var asDomain: DomainFirebase {
        var domain = DomainFirebase()
        domain.id = self.id 
        var candidateInfor = CandidateInforModel()
        candidateInfor.name = self.name
        candidateInfor.age = self.age
        candidateInfor.image = UIImage(data: Data(base64Encoded: self.image ?? "" ) ?? Data())
        candidateInfor.level = LevelInterView(rawValue: self.level ?? 0)
        candidateInfor.jobTitle = self.jobTitle
        domain.candidateInfor = candidateInfor
        var overview = OverviewModel()
        overview.content = self.overviewContent
        overview.status = StatusInterview(rawValue: self.result ?? 0)
        domain.overview = overview
        domain.date = self.date
        return domain
        
    }
}
