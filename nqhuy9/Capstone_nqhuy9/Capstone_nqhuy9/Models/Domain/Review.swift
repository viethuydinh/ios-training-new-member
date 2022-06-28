//
//  Review.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import Foundation

struct Review : Codable {
    var id: String?
    var candidateName: String?
    var content: String?
    var status: Bool
}

extension Review : ObjectConvert {
    var idFirebase: String? {
        get {
            return nil
        }
        set (newVal) {
            self.id = newVal
        }
    }
    
    typealias Object = ReviewCoreData
    
    var key: [String : String] {
        return ["id" : self.id ?? ""]
    }
    
    func update(object: ReviewCoreData?) -> ReviewCoreData {
        let value = object
        if value == nil { return ReviewCoreData() }
        value?.content = self.content
        value?.id = self.id ?? ""
        value?.candidateName = self.candidateName
        value?.status = self.status
        return value!
    }
}

