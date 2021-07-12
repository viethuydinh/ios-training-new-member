//
//  KnowledgeViewModel.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import Foundation

protocol KnowledgeViewModel {
    func createQuestion(question: Question)
    
    func createAnswer(answer: Answer)
    
    func createKnowledge(knowledge: Knowledge)
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {
    var repository : DefaultKnowledgeRepository
    
    init() {
        self.repository = DefaultKnowledgeRepository()
    }
    
    func createAnswer(answer: Answer) {
        self.repository.createAnswer(answer: answer)
    }
    
    func createQuestion(question: Question) {
        self.repository.createQuestion(question: question)
    }
    
    func createKnowledge(knowledge: Knowledge) {
        self.repository.createKnowledge(knowledge: knowledge)
    }
}
