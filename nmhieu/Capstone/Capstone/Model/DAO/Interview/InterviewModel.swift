//
//  InterviewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

struct InterviewModel {
    var id : String?
    var date : Date?
    var candidateInfor : CandidateInforModel?
    var listQuestions : [QuestionInterviewModel]?
    var overview : OverviewModel?
}

//extension InterviewModel : ObjectConvertible {
//    
//    typealias Object = InterviewCoreData
//    
//    func update(obj: InterviewCoreData) -> InterviewCoreData {
//        let object = obj
//        object.idCoreData = Int16(self.idCoreData ?? 0)
//        object.name = self.candidateInfor?.name
//        object.image = self.candidateInfor?.image?.pngData()?.base64EncodedString()
//        object.age = Int16(self.candidateInfor?.age ?? 0)
//        object.level = Int16(self.candidateInfor?.level?.rawValue ?? 0)
//        object.jobTitle = self.candidateInfor?.jobTitle
//        object.overviewContent = self.overview?.content
//        object.result = Int16(self.overview?.status?.rawValue ?? 0)
//        object.date = self.date ?? Date()
//        return object
//    }
//
//}

extension InterviewModel : ObjectConvertibleFirebase {
    
    typealias ObjectFirebase = InterviewDatabase
    
    func asObject() -> ObjectFirebase {
        var object = ObjectFirebase()
        object.id = self.id 
        object.name = self.candidateInfor?.name
        object.image = self.candidateInfor?.image?.pngData()?.base64EncodedString()
        object.age = self.candidateInfor?.age ?? 0
        object.level = self.candidateInfor?.level?.rawValue ?? 0
        object.jobTitle = self.candidateInfor?.jobTitle
        object.overviewContent = self.overview?.content
        object.result = self.overview?.status?.rawValue ?? 0
        object.date = self.date ?? Date()
        return object
    }
}
