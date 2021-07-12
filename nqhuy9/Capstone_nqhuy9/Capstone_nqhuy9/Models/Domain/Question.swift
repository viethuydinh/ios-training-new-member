//
//  Question.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/8/21.
//

import Foundation

struct Question {
    var id: Int16?
    var content: String?
    var level: String?
}

extension Question : ObjectConvert {
    
    typealias Object = QuestionCoreData
    
    var key: [String : String] {
        return ["content" : self.content ?? ""]
    }
    
    func update(object: QuestionCoreData?) -> QuestionCoreData {
        let value = object
        if value == nil { return QuestionCoreData() }
        value?.content = self.content
        value?.id = self.id ?? -1
        value?.level = self.level
        return value!
    }
}
