//
//  Question.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/8/21.
//

import Foundation

struct Question : Codable {
    var id: String?
    var content: String?
    var level: String?
    var answer: String?
}

extension Question : ObjectConvert {
    
    typealias Object = QuestionCoreData
    
    var idFirebase: String? {
        get {
            return nil
        }
        set (newVal) {
            self.id = newVal
        }
    }
    
    var key: [String : String] {
        return ["id" : self.id ?? ""]
    }
    
    func update(object: QuestionCoreData?) -> QuestionCoreData {
        let value = object
        if value == nil { return QuestionCoreData() }
        value?.content = self.content
        value?.id = self.id ?? ""
        value?.level = self.level
        value?.answer = self.answer
        return value!
    }
}
