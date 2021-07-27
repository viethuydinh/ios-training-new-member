//
//  InterviewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import Foundation
import UIKit

struct InterviewModel {
    var id : Int?
    var date : Date?
    var candidateInfor : CandidateInforModel?
    var listQuestions : [QuestionInterviewModel]?
    var overview : OverviewModel?
}

extension InterviewModel : ObjectConvertible {
    
    typealias Object = InterviewCoreData
    
    func update(obj: InterviewCoreData) -> InterviewCoreData {
        let object = obj
        object.id = Int16(self.id ?? 0)
        object.name = self.candidateInfor?.name
        object.image = self.candidateInfor?.image?.pngData()?.base64EncodedString()
        object.age = Int16(self.candidateInfor?.age ?? 0)
        object.level = Int16(self.candidateInfor?.level?.rawValue ?? 0)
        object.jobTitle = self.candidateInfor?.jobTitle
        object.overviewContent = self.overview?.content
        object.result = Int16(self.overview?.status?.rawValue ?? 0)
        object.date = self.date ?? Date()
        return object
    }
}
