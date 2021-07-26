//
//  KnowledgeViewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import Foundation
import UIKit

protocol KnowledgeViewModel : BaseViewModel {
    
    var level : LevelInterView { get set }
    
    var listKnowledges : [KnowledgeModel]  { get set }
    
    func saveListKnowledges()
    
    func updateKnowledge(knowledge : KnowledgeModel)
    
    func fetchKnowledge(level : LevelInterView) -> [KnowledgeModel]
    
    func deleteKnowledge(id : Int)
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {

    var knowledgeRepo = DefaulKnowledgeRepository()
    
    var level: LevelInterView = .intern
    
    var listKnowledges: [KnowledgeModel] = []
    
    func saveListKnowledges() {
        self.listKnowledges.forEach { knowledge in
            if !(knowledge.answer?.isEmpty ?? true)  && !(knowledge.content?.isEmpty ?? true){
                self.knowledgeRepo.insertKnowledge(knowledge: knowledge)
            }
        }
    }
    
    func fetchKnowledge(level: LevelInterView) -> [KnowledgeModel] {
        return knowledgeRepo.fetchQuestions(level: level)
    }
    
    func deleteKnowledge(id: Int) {
        self.knowledgeRepo.deleteKnowledge(id: id)
    }
    
    func updateKnowledge(knowledge : KnowledgeModel) {
        self.knowledgeRepo.updateKnowledge(knowledge: knowledge)
    }

    func clear() {
        
    }
}
