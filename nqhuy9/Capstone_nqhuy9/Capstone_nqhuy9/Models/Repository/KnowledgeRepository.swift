//
//  KnowledgeRepository.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import Foundation

protocol KnowledgeRepository {
    
    func createListQuestion(questions: [Question])
    
    func fetchListQuestion() -> [Question]
    
}

struct DefaultKnowledgeRepository: KnowledgeRepository {
    
    var questionDAO = CoreDataRepository<Question>.shared
    
    func createListQuestion(questions: [Question]) {
        if questions.count > 0 {
            let result = questionDAO.fetchAll(predicate: nil)
            var id : Int16 = Int16(result.count)
            
            var transformQuestions: [Question] = []
            for i in 1...questions.count {
                var q = questions[i-1]
                id += 1
                q.id = id
                transformQuestions.append(q)
            }
            questionDAO.saveAll(domains: transformQuestions)
        }
    }
    
    func fetchListQuestion() -> [Question] {
        return questionDAO.fetchAll(predicate: nil)
    }
    
}
