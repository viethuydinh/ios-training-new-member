//
//  KnowledgeViewModel.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import Foundation

protocol KnowledgeViewModel {
    var listQuestions: [Question] { get set }
    
    func createListQuestion(questions: [Question])
    
    func fetchListQuestion() -> [Question]
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {
    var repository : DefaultKnowledgeRepository
    
    var listQuestions: [Question] = []
    
    init() {
        self.repository = DefaultKnowledgeRepository()
    }
    
    func createListQuestion(questions: [Question]) {
        self.repository.createListQuestion(questions: questions)
    }
    
    func fetchListQuestion() -> [Question] {
        self.repository.fetchListQuestion()
    }
}
