//
//  AnswerModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation

struct AnswerModel {
    var id : Int?
    var content : String?
    var accuracy : Bool?
}

extension AnswerModel : ObjectConvertible {
    typealias Object = AnswerCoreData
    
    func update(obj: AnswerCoreData) -> AnswerCoreData {
        var object = obj
        object.id = Int16(self.id ?? 0)
        object.content = self.content
        object.accuracy = self.accuracy ?? false
        return object
    }
}
