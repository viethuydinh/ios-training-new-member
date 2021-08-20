//
//  InterviewRepository.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import Foundation

protocol InterviewRepository {
    func recommentQuestion(level : LevelInterView) -> [QuestionInterviewModel]
    
    func recommentQuestion(level : LevelInterView, completion : @escaping ([QuestionInterviewModel], Error?) -> ())
    
    func saveInterView(data : InterviewModel)
    
    func saveInterView(data : InterviewModel, completion : @escaping(Error?) -> ())
    
    func fetchInterviewHistory(completion : @escaping ([InterviewModel], Error?) -> ())
    
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
            result.idCoredata = questions[id].idCoreData
            result.question = questions[id].content
            result.answer = questions[id].answer
            result.rate = .good
            results.append(result)
        }

        return results
    }
    
    func recommentQuestion(level: LevelInterView, completion: @escaping ([QuestionInterviewModel], Error?) -> ()) {
        FirebaseRepository<KnowledgeModel>.shared.fetch(limit: 5, whereFeild: "level", isEqualTo: level.rawValue, completion: { response, error in
            var results : [QuestionInterviewModel] = []
            guard let knowledges = response else { return }
            knowledges.forEach { knowledge in
                var result = QuestionInterviewModel()
                result.id = knowledge.id
                result.question = knowledge.content
                result.answer = knowledge.answer
                result.rate = .good
                results.append(result)
            }
            completion(results, error)
        })
    }
    
    func saveInterView(data: InterviewModel) {
        var id : Int = 0
//        idCoreData = CoreDataRepository<InterviewModel>.shared.fetchAll()?.count ?? 0
        
        var interviewData = data
//        interviewData.idCoreData = idCoreData
        
        let questionsInterviewData = data.listQuestions
    
//        CoreDataRepository<InterviewModel>.shared.save(domain: interviewData)
        questionsInterviewData?.forEach({ (question) in
            var questionInterview = question
            questionInterview.idCoredata = id
            CoreDataRepository<QuestionInterviewModel>.shared.save(domain: questionInterview)
        })
    }
    
    func saveInterView(data: InterviewModel, completion: @escaping (Error?) -> ()) {
        FirebaseRepository<InterviewModel>.shared.save(domain: data) { error in
            completion(error)
        }
    }
    
    func fetchInterviewHistory(completion : @escaping ([InterviewModel],Error?) -> ()) {
        FirebaseRepository<InterviewModel>.shared.fetchAll(completion: { interviewDatabase, error in
            guard let interview = interviewDatabase else { return }
            completion(interview ,error)
        })
    }
    
    func fetchInterviewHistory() -> [InterviewModel] {
        return []
    }
}
