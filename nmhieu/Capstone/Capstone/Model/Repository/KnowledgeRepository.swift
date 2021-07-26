//
//  KnowledgeRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation

protocol KnowledgeRepository {
    
    func insertKnowledge(knowledge : KnowledgeModel)
    
    func updateKnowledge(knowledge : KnowledgeModel)
    
    func fetchQuestions(level : LevelInterView) -> [KnowledgeModel]
    
    func deleteKnowledge(id : Int)
}


struct DefaulKnowledgeRepository : KnowledgeRepository {
    
    func insertKnowledge(knowledge: KnowledgeModel) {
        var id : Int?
        id = CoreDataRepository<KnowledgeModel>.shared.fetchAll()?.count ?? -1 + 1
        
        var questionData = knowledge
        questionData.id = id
        
        CoreDataRepository<KnowledgeModel>.shared.save(domain: questionData)
    }
    
    func updateKnowledge(knowledge : KnowledgeModel) {
        let predicate : NSPredicate = .init(format: "id == \(knowledge.id ?? 0)")
        CoreDataRepository<KnowledgeModel>.shared.update(domain: knowledge, predicate: predicate)
    }
    
    func fetchQuestions(level: LevelInterView) -> [KnowledgeModel] {
        let predicate = NSPredicate(format: "level == \(level.rawValue)")
        
        guard let quesions = CoreDataRepository<KnowledgeModel>.shared.fetchList(predicate : predicate) else {
            return []
        }
        return quesions
    }
    
    func deleteKnowledge(id: Int) {
        let predicate = NSPredicate(format: "id == \(id)")
        
        CoreDataRepository<KnowledgeModel>.shared.delete(predicate: predicate)
    }

}
