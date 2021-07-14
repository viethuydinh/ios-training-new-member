//
//  InterviewRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import Foundation

protocol InterviewRepository {
    func recommentQuestion(level : LevelInterView) -> [QuestionInterviewModel]
}

struct DefaultInterviewRepository : InterviewRepository {
    
    func recommentQuestion(level : LevelInterView) -> [QuestionInterviewModel] {
        var results : [QuestionInterviewModel] = []
        let predicateLevel : NSPredicate = .init(format: "level = %d", argumentArray: [level.rawValue])
        guard let questions = CoreDataRepository<QuestionModel>.shared.fetch(predicate: predicateLevel) as? [QuestionModel] else { return [] }
        
        let idRandom : [Int] = (1...5).map{_ in .random(in: 0..<questions.count)}
        
        idRandom.forEach { (id) in
            var result = QuestionInterviewModel()
            result.id = questions[id].id
            result.question = questions[id].content
            result.rate = .good
            results.append(result)
        }

        return results
    }
}
