//
//  Answer.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/8/21.
//

import Foundation

struct Answer {
    var id : Int16?
    var content : String?
    var accuracy : Bool
}

extension Answer : ObjectConvert {
    var key: [String : String] {
        return ["content" : self.content ?? ""]
    }

    typealias Object = AnswerCoreData

    func update(object: AnswerCoreData?) -> AnswerCoreData {
        var value = object
        if value == nil { value = AnswerCoreData() }
        value?.content = self.content
        value?.accuracy = self.accuracy
        value?.id = self.id ?? -1
        return value!
    }
}
