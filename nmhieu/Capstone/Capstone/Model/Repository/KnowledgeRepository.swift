//
//  KnowledgeRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation

protocol KnowledgeRepository {
    
    func insertKnowledge(knowledge : KnowledgeModel)
    
    func fetchQuestions(level : LevelInterView) -> [KnowledgeModel]
}


struct DefaulKnowledgeRepository : KnowledgeRepository {
    
    func insertKnowledge(knowledge: KnowledgeModel) {
        var id : Int?
        id = CoreDataRepository<KnowledgeModel>.shared.fetchAll()?.count ?? -1 + 1
        
        var questionData = knowledge
        questionData.id = id
        
        CoreDataRepository<KnowledgeModel>.shared.save(domain: questionData)
    }
    
    func fetchQuestions(level: LevelInterView) -> [KnowledgeModel] {
        let predicate = NSPredicate(format: "level == \(level.rawValue)")
        
        guard let quesions = CoreDataRepository<KnowledgeModel>.shared.fetchList(predicate : predicate) else {
            return []
        }
        return quesions
    }

}
