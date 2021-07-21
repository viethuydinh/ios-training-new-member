//
//  InterviewRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import Foundation

protocol InterviewRepository {
    func recommentQuestion(level : LevelInterView) -> [QuestionInterviewModel]
    
    func saveInterView(data : InterviewModel)
    
    func fetchInterviewHistory() -> [InterviewModel]
}

struct DefaultInterviewRepository : InterviewRepository {
    
    func recommentQuestion(level : LevelInterView) -> [QuestionInterviewModel] {
        var results : [QuestionInterviewModel] = []
        let predicateLevel : NSPredicate = .init(format: "level == \(level.rawValue)")
        
        guard let questions = CoreDataRepository<KnowledgeModel>.shared.fetchList(predicate: predicateLevel) else { return [] }
        
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
    
    func saveInterView(data: InterviewModel) {
        var id : Int = 0
        id = CoreDataRepository<InterviewModel>.shared.fetchAll()?.count ?? 0
        
        var interviewData = data
        interviewData.id = id
        
        let questionsInterviewData = data.listQuestions
    
        CoreDataRepository<InterviewModel>.shared.save(domain: interviewData)
        questionsInterviewData?.forEach({ (question) in
            var questionInterview = question
            questionInterview.id = id
            CoreDataRepository<QuestionInterviewModel>.shared.save(domain: questionInterview)
        })
    }
    
    func fetchInterviewHistory() -> [InterviewModel] {
        var historyInterview : [InterviewModel]  = []
        guard let interview = CoreDataRepository<InterviewModel>.shared.fetchAll() else { return [] }
        historyInterview = interview
        return historyInterview
    }
}
