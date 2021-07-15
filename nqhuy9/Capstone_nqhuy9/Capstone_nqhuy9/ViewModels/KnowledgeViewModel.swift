//
//  KnowledgeViewModel.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import Foundation

protocol KnowledgeViewModel {
    var listQuestions: [Question] { get set }
    
    var listLevel: [LevelKnowledge] { get set }
    
    var level: LevelKnowledge { get set }
    
    func createListQuestion(questions: [Question])
    
    func fetchListQuestion() -> [Question]
    
    func fetchRecommendQuestion() -> [Question]
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {
    var repository : DefaultKnowledgeRepository
    
    var listQuestions: [Question] = []
    
    var listLevel: [LevelKnowledge] = [.fresher, .junior, .middle, .senior]
    
    var level: LevelKnowledge = .fresher
    
    init() {
        self.repository = DefaultKnowledgeRepository()
    }
    
    func createListQuestion(questions: [Question]) {
        self.repository.createListQuestion(questions: questions)
    }
    
    func fetchListQuestion() -> [Question] {
        return self.repository.fetchListQuestion(predicate: .init(format: "level = %@", argumentArray: [self.level.rawValue]))
    }
    
    func fetchRecommendQuestion() -> [Question] {
        return self.repository.fetchRecommendQuestion(predicate: .init(format: "level = %@", argumentArray: [self.level.rawValue]))
    }
}
