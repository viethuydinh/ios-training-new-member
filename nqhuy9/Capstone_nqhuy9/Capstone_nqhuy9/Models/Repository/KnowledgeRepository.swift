//
//  KnowledgeRepository.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import Foundation

protocol KnowledgeRepository {
    
    func createListQuestion(questions: [Question]) -> Bool
    
    func fetchListQuestion(predicate: NSPredicate?) -> [Question]
    
    func fetchRecommendQuestion(predicate: NSPredicate?) -> [Question]
    
    func deleteQuestion(id: Int16?) -> Bool
    
    func editQuestion(question: Question) -> Bool
    
}

struct DefaultKnowledgeRepository: KnowledgeRepository {
    
    var questionDAO = CoreDataRepository<Question>.shared
    
    func createListQuestion(questions: [Question]) -> Bool {
        if questions.count > 0 {
            let result = questionDAO.fetchAll(predicate: nil)
            var id : Int16 = Int16(result.count)
            
            var transformQuestions: [Question] = []
            for i in 1...questions.count {
                var q = questions[i-1]
                id += 1
                q.id = id
                if q.answer != "" && q.content != "" {
                    transformQuestions.append(q)
                }
            }
            return questionDAO.saveAll(domains: transformQuestions)
        } else {
            return false
        }
    }
    
    func fetchListQuestion(predicate: NSPredicate?) -> [Question] {
        return questionDAO.fetchAll(predicate: predicate)
    }
    
    func fetchRecommendQuestion(predicate : NSPredicate?) -> [Question] {
        return Array(self.fetchListQuestion(predicate: predicate).choose(8))
    }
    
    func deleteQuestion(id: Int16?) -> Bool {
        guard let idDelete = id else { return false }
        return self.questionDAO.deleteAll(predicate: .init(format: "id = %@", argumentArray: [String(idDelete)]))
    }
    
    func editQuestion(question: Question) -> Bool {
        return self.questionDAO.save(domain: question)
    }
    
}
