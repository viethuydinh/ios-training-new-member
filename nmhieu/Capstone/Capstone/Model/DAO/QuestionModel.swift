//
//  QuestionModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation

struct QuestionModel {
    var id : Int?
    var content : String?
    var level : LevelInterView?
}

enum LevelInterView : Int {
    case intern = 0
    case fresher = 1
    case junior = 2
    case senior = 3
}

extension QuestionModel : ObjectConvertible {
    typealias Object = QuestionCoreData
    
    func update(obj: QuestionCoreData) -> QuestionCoreData {
        var object = obj
        object.id = Int16(self.id ?? 0)
        object.content = self.content
        object.level = Int16(self.level?.rawValue ?? 0)
        return object
    }
}
