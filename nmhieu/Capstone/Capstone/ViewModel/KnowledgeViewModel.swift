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
    
    func saveKnowledge(tableView : UITableView)
    
    func saveListKnowledges()
    
    func getQuestions(tableView : UITableView) -> [KnowledgeModel]
    
    func fetchQuestion(level : LevelInterView) -> [KnowledgeModel]
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {

    var knowledgeRepo = DefaulKnowledgeRepository()
    
    var level: LevelInterView = .intern
    
    var listKnowledges: [KnowledgeModel] = []
    
    var numberOfRow: Int = 0
    
    func saveKnowledge(tableView : UITableView) {
//        let questions = self.getQuestions(tableView: tableView)
//        questions.forEach { (question) in
//            let result = knowledgeRepo.insertKnowledge(knowledge: question)
//            print(result)
//        }
    }
    
    func saveListKnowledges() {
        self.listKnowledges.forEach { knowledge in
            self.knowledgeRepo.insertKnowledge(knowledge: knowledge)
        }
    }
    
    func getQuestions(tableView : UITableView) -> [KnowledgeModel] {
        var questions : [KnowledgeModel] = []
        for row in 0...self.numberOfRow {
            let indexPath = IndexPath(row: row, section: 0)
            
            guard let cell = tableView.cellForRow(at: indexPath) as? KnowledgeTableViewCell else {
                return questions
            }
            
            guard let question = cell.getKnowlege() else { return questions }
            questions.append(question)
        }
        
        return questions
    }
    
    func fetchQuestion(level: LevelInterView) -> [KnowledgeModel] {
        return knowledgeRepo.fetchQuestions(level: level)
    }
}
