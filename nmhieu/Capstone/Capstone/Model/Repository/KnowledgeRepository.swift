//
//  KnowledgeRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation

protocol KnowledgeRepository {
    
    func insertKnowledge(question : QuestionModel) -> Bool
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
//        CoreDataRepository<QuestionModel>.shared.fetchAll()?.forEach({ (quesion) in
//            print(question)
//        })
        return true
        
    }

}
