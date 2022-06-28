//
//  KnowledgeRepository.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import Foundation

protocol KnowledgeRepository {
    
    func createListQuestion(questions: [Question]) -> Bool
    
    func fetchListQuestion(field: String?, targetCondition: Any?, completion: @escaping(([Question]) -> ())) -> Bool
    
    func fetchRecommendQuestion(field: String?, targetCondition: Any?, completion: @escaping(([Question]) -> ())) -> Bool
    
    func deleteQuestion(id: String?) -> Bool
    
    func editQuestion(question: Question) -> Bool
    
}

struct DefaultKnowledgeRepository: KnowledgeRepository {
    
    var questionDAO = CoreDataRepository<Question>.shared
    
    var questionFirebase = FirebaseRepository<Question>.shared
    
    func createListQuestion(questions: [Question]) -> Bool {
        return questionFirebase.saveAll(tableName: "Question", domains: questions)
    }
    
    func fetchListQuestion(field: String?, targetCondition: Any?, completion: @escaping(([Question]) -> ())) -> Bool {
        return questionFirebase.fetchAll(tableName: "Question", field: field, targetCondition: targetCondition) { questions in
            completion(questions)
        }
    }
    
    func fetchRecommendQuestion(field: String?, targetCondition: Any?, completion: @escaping(([Question]) -> ())) -> Bool {
        return self.fetchListQuestion(field: field, targetCondition: targetCondition) { questions in
            completion(Array(questions.choose(8)))
        }
    }
    
    func deleteQuestion(id: String?) -> Bool {
        guard let idDelete = id else { return false }
        return questionFirebase.delete(tableName: "Question", value: idDelete)
    }
    
    func editQuestion(question: Question) -> Bool {
        return self.questionFirebase.save(tableName: "Question", domain: question, id: question.id)
    }
    
}
