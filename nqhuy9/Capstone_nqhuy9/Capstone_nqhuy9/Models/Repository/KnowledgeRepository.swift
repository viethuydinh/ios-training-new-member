//
//  KnowledgeRepository.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import Foundation

protocol KnowledgeRepository {
    
    func createQuestion(question: Question)
    
    func createAnswer(answer: Answer)
    
    func createKnowledge(knowledge: Knowledge)
    
}

struct DefaultKnowledgeRepository: KnowledgeRepository {
    
    var questionDAO = CoreDataRepository<Question>.shared
    
    var answerDAO = CoreDataRepository<Answer>.shared
    
    func createKnowledge(knowledge: Knowledge) {
        let result = questionDAO.fetchAll(predicate: nil)
        let nextId: Int16 = Int16(result.count + 1)
        guard var question = knowledge.question else { return }
        question.id = nextId
        let answers = knowledge.answers.map{ Answer(id: nextId, content: $0.content, accuracy: $0.accuracy) }
        questionDAO.save(domain: question)
        answerDAO.saveAll(domains: answers)
    }
    
    func createAnswer(answer: Answer) {
        let result = questionDAO.fetchAll(predicate: nil)
        let nextId: Int16 = Int16(result.count + 1)
        answerDAO.save(domain: Answer(id: nextId, content: answer.content, accuracy: answer.accuracy))
    }
    
    func createQuestion(question: Question) {
        let result = questionDAO.fetchAll(predicate: nil)
        let nextId: Int16 = Int16(result.count + 1)
        questionDAO.save(domain: Question(id: nextId, content: question.content, level: question.level))
    }
    
}
