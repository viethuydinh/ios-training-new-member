//
//  KnowledgeRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation

protocol KnowledgeRepository {
    
    func insertKnowledge(question : QuestionModel) -> Bool
    
    func fetchQuestions(level : LevelInterView) -> [QuestionModel]
}


struct DefaulKnowledgeRepository : KnowledgeRepository {
    
    func insertKnowledge(question: QuestionModel) -> Bool {
        var id : Int = 0
        id = CoreDataRepository<QuestionModel>.shared.fetchAll()?.count ?? 0
        
        var questionData = question
        questionData.id = id
        questionData.content = question.content
        questionData.level = question.level
        
        CoreDataRepository<QuestionModel>.shared.save(domain: questionData)
        return true
        
    }
    
    func fetchQuestions(level: LevelInterView) -> [QuestionModel] {
        let predicate = NSPredicate(format: "level == \(level.rawValue)")
        
        guard let quesions = CoreDataRepository<QuestionModel>.shared.fetchList(predicate : predicate) else {
            return []
        }
        return quesions
    }

}
