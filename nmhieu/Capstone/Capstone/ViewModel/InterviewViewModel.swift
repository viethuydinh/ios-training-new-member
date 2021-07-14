//
//  InterviewViewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import Foundation

protocol InterviewViewModel {
    var section : InterviewSection? { get }
    
    var level : LevelInterView { get set }
    
    func recommentListQuestions() -> [QuestionInterviewModel]
}

struct DefaultInterviewViewModel : InterviewViewModel {
    
    var interViewRepository = DefaultInterviewRepository()
    
    var level: LevelInterView = .intern

    var section: InterviewSection?
    
    func recommentListQuestions() -> [QuestionInterviewModel] {
        return self.interViewRepository.recommentQuestion(level: self.level)
    }
    
    
    
}
