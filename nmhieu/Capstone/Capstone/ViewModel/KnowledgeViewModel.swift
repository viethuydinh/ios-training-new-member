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
    
    func saveKnowledge(tableView : UITableView)
    
    func getQuestions(tableView : UITableView) -> [QuestionModel]
    
    func fetchQuestion(level : LevelInterView) -> [QuestionModel]
}

struct DefaultKnowledgeViewModel : KnowledgeViewModel {
    
    var knowledgeRepo = DefaulKnowledgeRepository()
    
    var level: LevelInterView = .intern
    
    var numberOfRow: Int = 0
    
    func saveKnowledge(tableView : UITableView) {
        let questions = self.getQuestions(tableView: tableView)
        questions.forEach { (question) in
            let result = knowledgeRepo.insertKnowledge(question: question)
            print(result)
        }
    }
    
    func getQuestions(tableView : UITableView) -> [QuestionModel] {
        var questions : [QuestionModel] = []
        for row in 0...self.numberOfRow {
            let indexPath = IndexPath(row: row, section: 0)
            
            guard let cell = tableView.cellForRow(at: indexPath) as? KnowledgeTableViewCell else {
                return questions
            }
            
            guard let question = cell.getData() else { return questions }
            questions.append(question)
        }
        
        return questions
    }
    
    func fetchQuestion(level: LevelInterView) -> [QuestionModel] {
        return knowledgeRepo.fetchQuestions(level: level)
    }
}
