//
//  KnowledgeViewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation
import UIKit

protocol KnowledgeViewModel {
    
    var numberOfRow : Int { get set }
    
    var level : LevelInterView { get set }
    
    var listKnowledges : [KnowledgeModel]  { get set }
    
    func saveListKnowledges()
    
    func fetchQuestion(level : LevelInterView) -> [KnowledgeModel]
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {

    var knowledgeRepo = DefaulKnowledgeRepository()
    
    var level: LevelInterView = .intern
    
    var listKnowledges: [KnowledgeModel] = []
    
    var numberOfRow: Int = 0
    
    func saveListKnowledges() {
        self.listKnowledges.forEach { knowledge in
            self.knowledgeRepo.insertKnowledge(knowledge: knowledge)
        }
    }
    
    func fetchQuestion(level: LevelInterView) -> [KnowledgeModel] {
        return knowledgeRepo.fetchQuestions(level: level)
    }
}
