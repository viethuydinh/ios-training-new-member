//
//  KnowledgeViewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation

protocol KnowledgeViewModel {
    
    var knowledge : [KnowledgeModel]? { get set }
    
    var numberOfRow : Int { get set }
    
    var level : LevelInterView { get set }
    
    func saveKnowledge()
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {

    var knowledgeRepo = DefaulKnowledgeRepository()
    
    var level: LevelInterView = .intern
    
    var knowledge: [KnowledgeModel]? = []

    var numberOfRow: Int = 0
    
    func saveKnowledge() {
        guard let knowledegeData = self.knowledge else {
            return
        }
        
        knowledegeData.forEach { (data) in
            guard let questionData = data.question else { return }
            guard let answerData = data.answer else { return }
            self.knowledgeRepo.insertKnowledge(question: questionData, answer: answerData)
        }
    }
    
}
