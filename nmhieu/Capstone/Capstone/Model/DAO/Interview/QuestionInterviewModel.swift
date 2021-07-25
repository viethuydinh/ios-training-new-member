//
//  QuestionInterviewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import Foundation

struct QuestionInterviewModel {
    var id : Int?
    var question : String?
    var answer : String?
    var rate : RateAnswer?
}

enum RateAnswer: Int,Codable  {
    case good = 0
    case nomal = 1
    case bad = 2
    
    var title : String {
        switch self {
        case .good:
            return "Good"
        case .nomal:
            return "Nomal"
        case .bad:
            return "Bad"
        }
    }
}

extension QuestionInterviewModel : ObjectConvertible {
    
    typealias Object = QuestionInterViewCoreData
    
    func update(obj: QuestionInterViewCoreData) -> QuestionInterViewCoreData {
        let object = obj
        object.id = Int16(self.id ?? 0)
        object.question = self.question
        object.answer = self.answer
        object.rate = Int16(self.rate?.rawValue ?? 0)
        return object
    }
    
}
