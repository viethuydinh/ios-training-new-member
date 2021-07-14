//
//  Review.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import Foundation

struct Review {
    var id: Int16?
    var candidateName: String?
    var content: String?
    var status: Bool
}

extension Review : ObjectConvert {
    typealias Object = ReviewCoreData
    
    var key: [String : String] {
        return ["id" : String(self.id ?? -1)]
    }
    
    func update(object: ReviewCoreData?) -> ReviewCoreData {
        let value = object
        if value == nil { return ReviewCoreData() }
        value?.content = self.content
        value?.id = self.id ?? -1
        value?.candidateName = self.candidateName
        value?.status = self.status
        return value!
    }
}

