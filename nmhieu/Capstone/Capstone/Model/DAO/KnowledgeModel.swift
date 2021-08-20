//
//  KnowledgeModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct KnowledgeModel {
    var id : String?
    var idCoreData : Int?
    var content : String?
    var answer : String?
    var level : LevelInterView?
}

enum LevelInterView : Int,Codable {
    case intern = 0
    case fresher = 1
    case junior = 2
    case senior = 3
    
    var title : String {
        switch self {
        case .intern:
            return "Intern"
        case .fresher:
            return "Fresher"
        case .junior:
            return "Junior"
        case .senior:
            return "Senior"
        }
    }
}

extension KnowledgeModel : ObjectConvertible {
    typealias Object = KnowledgeCoreData

    func update(obj: Object) -> Object {
        let object = obj
        object.id = Int16(self.idCoreData ?? 0)
        object.content = self.content
        object.answer = self.answer
        object.level = Int16(self.level?.rawValue ?? 0)
        return object
    }
}

extension KnowledgeModel : ObjectConvertibleFirebase {
    
    typealias ObjectFirebase = KnowledgeDatabase
    
    func asObject() -> ObjectFirebase {
        var object = ObjectFirebase()
        object.id = self.id
        object.content = self.content
        object.answer = self.answer
        object.level = self.level?.rawValue ?? 0
        return object
    }
}
