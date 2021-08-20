//
//  KnowledgeDatabase.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 19/08/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct KnowledgeDatabase : Codable {
    @DocumentID var id : String?
    var answer : String?
    var content : String?
    var level : Int?
}

extension KnowledgeDatabase : DomainConvertibleFirebase {
   
    typealias DomainFirebase = KnowledgeModel
    
    var asDomain: DomainFirebase {
        var domain = DomainFirebase()
        domain.id = self.id
        domain.content = self.content
        domain.answer = self.answer
        domain.level = LevelInterView(rawValue: Int(self.level ?? 0))
        return domain
    }
    
}
