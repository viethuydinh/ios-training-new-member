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
    var name : String?
    var age : Int?
    var image : UIImage?
    var level : LevelInterView?
    var listQuestions : QuestionInterviewModel?
    var overviewContent : String?
    var resultInterview : ResultInterview?
    var date : Date?
}

enum ResultInterview : Int {
    case pass = 0
    case fail = 1
    
    var title : String {
        switch self {
        case .pass:
            return "Pass"
        case .fail:
            return "Fail"
        }
    }
}

extension InterviewModel : ObjectConvertible {
    typealias Object = InterviewCoreData
    
    func update(obj: InterviewCoreData) -> InterviewCoreData {
        var object = obj
        object.id = Int16(self.id ?? 0)
        object.name = self.name
        object.image = self.image?.pngData()?.base64EncodedString()
        object.age = Int16(self.age ?? 0)
        object.level = Int16(self.level?.rawValue ?? 0)
        object.overviewContent = self.overviewContent
        object.result = Int16(self.resultInterview?.rawValue ?? 0)
        object.date = self.date ?? Date()
        return object
    }
}
