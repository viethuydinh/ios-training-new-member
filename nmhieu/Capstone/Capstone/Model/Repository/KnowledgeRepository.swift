//
//  KnowledgeRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation

protocol KnowledgeRepository {
    
    func insertKnowledge(knowledge : KnowledgeModel)
    
    func insertKnowledge(knowledge : KnowledgeModel, completion : @escaping (Error?) ->())
    
    func updateKnowledge(knowledge : KnowledgeModel)
    
    func updateKnowledge(knowledge : KnowledgeModel, completion : @escaping (Error?) -> ())
    
    func fetchQuestions(level : LevelInterView) -> [KnowledgeModel]
    
    func fetchQuestions(level : LevelInterView, completion : @escaping ([KnowledgeModel], Error?) -> ())
    
    func deleteKnowledge(id : Int)
    
    func deleteKnowledge(id : String, completion : @escaping (Error?) ->())
}


struct DefaultKnowledgeRepository : KnowledgeRepository {
   
    func insertKnowledge(knowledge: KnowledgeModel) {
        var id : Int?
        id = CoreDataRepository<KnowledgeModel>.shared.fetchAll()?.count ?? -1 + 1
        
        var questionData = knowledge
        questionData.idCoreData = id
        
        CoreDataRepository<KnowledgeModel>.shared.save(domain: questionData)
    }
    
    func insertKnowledge(knowledge: KnowledgeModel, completion: @escaping (Error?) -> ()) {
        FirebaseRepository<KnowledgeModel>.shared.save(domain: knowledge) { error in
            completion(error)
        }
    }
    
    func updateKnowledge(knowledge : KnowledgeModel) {
        let predicate : NSPredicate = .init(format: "idCoreData == \(knowledge.idCoreData ?? 0)")
        CoreDataRepository<KnowledgeModel>.shared.update(domain: knowledge, predicate: predicate)
    }
    
    func updateKnowledge(knowledge: KnowledgeModel, completion: @escaping (Error?) -> ()) {
        FirebaseRepository<KnowledgeModel>.shared.update(documentID: knowledge.id ?? "", domain: knowledge) { error in
            completion(error)
        }
    }
    
    func fetchQuestions(level: LevelInterView) -> [KnowledgeModel] {
        let predicate = NSPredicate(format: "level == \(level.rawValue)")
        
        guard let quesions = CoreDataRepository<KnowledgeModel>.shared.fetchList(predicate : predicate) else {
            return []
        }
        return quesions
    }
    
    func fetchQuestions(level: LevelInterView, completion: @escaping ([KnowledgeModel], Error?) -> ()) {
        FirebaseRepository<KnowledgeModel>.shared.fetch(whereFeild: "level", isEqualTo: level.rawValue) { response, error in
            guard let knowledges = response else { return }
            completion(knowledges, error)
        }
    }
    
    func deleteKnowledge(id: Int) {
        let predicate = NSPredicate(format: "idCoreData == \(id)")
        
        CoreDataRepository<KnowledgeModel>.shared.delete(predicate: predicate)
    }
    
    func deleteKnowledge(id: String, completion: @escaping (Error?) -> ()) {
        FirebaseRepository<KnowledgeModel>.shared.delete(documentID: id) { error in
            completion(error)
        }
    }

}
