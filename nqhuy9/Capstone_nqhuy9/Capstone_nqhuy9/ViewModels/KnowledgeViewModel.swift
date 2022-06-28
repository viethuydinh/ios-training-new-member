//
//  KnowledgeViewModel.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/12/21.
//

import Foundation
import RxSwift

protocol KnowledgeViewModel {
    var listQuestions: [Question] { get set }
    
    var listLevel: [LevelKnowledge] { get set }
    
    var level: LevelKnowledge { get set }
    
    var isHaveTabBar: BehaviorSubject<Bool> {get set}
    
    func createListQuestion(questions: [Question]) -> Bool
    
    func fetchListQuestion(completion: @escaping(([Question]) -> ())) -> Bool
    
    func fetchRecommendQuestion(completion: @escaping(([Question]) -> ())) -> Bool
    
    func deleteQuestion(id: String?) -> Bool
    
    func editQuestion(question: Question) -> Bool
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {
    
    var isHaveTabBar: BehaviorSubject<Bool> = .init(value: true)
    
    var repository : DefaultKnowledgeRepository
    
    var listQuestions: [Question] = []
    
    var listLevel: [LevelKnowledge] = [.fresher, .junior, .middle, .senior]
    
    var level: LevelKnowledge = .fresher
    
    init() {
        self.repository = DefaultKnowledgeRepository()
    }
    
    func createListQuestion(questions: [Question]) -> Bool {
        return self.repository.createListQuestion(questions: questions)
    }
    
    func fetchListQuestion(completion: @escaping(([Question]) -> ())) -> Bool {
        return self.repository.fetchListQuestion(field: "level", targetCondition: self.level.rawValue) { questions in
            completion(questions)
        }
    }
    
    func fetchRecommendQuestion(completion: @escaping(([Question]) -> ())) -> Bool {
        return self.repository.fetchRecommendQuestion(field: "level", targetCondition: self.level.rawValue) { questions in
            completion(questions)
        }
    }
    
    func deleteQuestion(id: String?) -> Bool {
        return self.repository.deleteQuestion(id: id)
    }
    
    func editQuestion(question: Question) -> Bool {
        return self.repository.editQuestion(question: question)
    }
}
