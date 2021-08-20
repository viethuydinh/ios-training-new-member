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
    
    func saveListKnowledges(completion : @escaping (Error?) -> ())
    
    func updateKnowledge(knowledge : KnowledgeModel)
    
    func updateKnowledge(knowledge : KnowledgeModel, completion : @escaping (Error?) -> ())
    
    func fetchKnowledge(level : LevelInterView) -> [KnowledgeModel]
    
    func fetchKnowledge(level : LevelInterView, completion : @escaping ([KnowledgeModel], Error?) -> ())
    
    func deleteKnowledge(id : Int)
    
    func deleteKnowledge(id : String, completion : @escaping (Error?) -> ())
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {
    
    @Inject var knowledgeRepo : KnowledgeRepository
    
    var level: LevelInterView = .intern
    
    var listKnowledges: [KnowledgeModel] = []
    
    func saveListKnowledges() {
        self.listKnowledges.forEach { knowledge in
            if !(knowledge.answer?.isEmpty ?? true)  && !(knowledge.content?.isEmpty ?? true){
                self.knowledgeRepo.insertKnowledge(knowledge: knowledge)
            }
        }
    }
    
    func saveListKnowledges(completion: @escaping (Error?) -> ()) {
        self.listKnowledges.forEach { knowledge in
            if !(knowledge.answer?.isEmpty ?? true)  && !(knowledge.content?.isEmpty ?? true){
                self.knowledgeRepo.insertKnowledge(knowledge: knowledge) { error in
                    completion(error)
                }
            }
        }
    }
    
    func fetchKnowledge(level: LevelInterView) -> [KnowledgeModel] {
        return knowledgeRepo.fetchQuestions(level: level)
    }
    
    func fetchKnowledge(level: LevelInterView, completion: @escaping ([KnowledgeModel], Error?) -> ()) {
        self.knowledgeRepo.fetchQuestions(level: level) { response, error in
            completion(response, error)
        }
    }
    
    func deleteKnowledge(id: Int) {
        self.knowledgeRepo.deleteKnowledge(id: id)
    }
    
    func deleteKnowledge(id: String, completion: @escaping (Error?) -> ()) {
        self.knowledgeRepo.deleteKnowledge(id: id) { error in
            completion(error)
        }
    }
    
    func updateKnowledge(knowledge : KnowledgeModel) {
        self.knowledgeRepo.updateKnowledge(knowledge: knowledge)
    }
    
    func updateKnowledge(knowledge: KnowledgeModel, completion: @escaping (Error?) -> ()) {
        self.knowledgeRepo.updateKnowledge(knowledge: knowledge, completion: { error in
            completion(error)
        })
    }

    func clear() {
        
    }
}
