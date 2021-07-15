//
//  InterviewViewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import Foundation
import UIKit

protocol InterviewViewModel {
    var image : UIImage? { get set }
    
    var level : LevelInterView { get set }
    
    func recommentListQuestions() -> [QuestionInterviewModel]
    
    func saveInterView(tableView : UITableView)
    
    func getDataOnCadidateProfileSection(tableView : UITableView) -> CandidateInforModel
    
    func getDataOnQuestionSection(tableView : UITableView) -> [QuestionInterviewModel]
    
    func getDataOnOverviewSection(tableView : UITableView) -> OverviewModel
}

struct DefaultInterviewViewModel : InterviewViewModel {
    
    var interViewRepository = DefaultInterviewRepository()
    
    var image: UIImage?
    
    var level: LevelInterView = .intern
    
    func recommentListQuestions() -> [QuestionInterviewModel] {
        return self.interViewRepository.recommentQuestion(level: self.level)
    }
    
    func saveInterView(tableView : UITableView) {
        var interviewData = InterviewModel()
        interviewData.id = nil
        interviewData.date = Date()
        interviewData.candidateInfor = self.getDataOnCadidateProfileSection(tableView: tableView)
        interviewData.listQuestions = self.getDataOnQuestionSection(tableView: tableView)
        interviewData.overview = self.getDataOnOverviewSection(tableView: tableView)
        
        self.interViewRepository.saveInterView(data: interviewData)
    }
    
    func getDataOnCadidateProfileSection(tableView: UITableView) -> CandidateInforModel {
        let indexPath = IndexPath(row : 0, section: InterviewSection.candidateInfor.rawValue)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CandidateInforTableViewCell else  { return CandidateInforModel() }
        
        var candidateInfor = CandidateInforModel()
        candidateInfor = cell.getCandidateInfor()
        
        return candidateInfor
    }
    
    func getDataOnQuestionSection(tableView: UITableView) -> [QuestionInterviewModel] {
        var questions : [QuestionInterviewModel] = []
        
        for row in 0..<5 {
            let indexPath = IndexPath(row: row, section: InterviewSection.questions.rawValue)
            guard let cell = tableView.cellForRow(at: indexPath) as? QuestionTableViewCell else  { return [] }
            questions.append(cell.getQuestion())
        }
        
        return questions
    }
    
    func getDataOnOverviewSection(tableView: UITableView) -> OverviewModel {
        let indexPath = IndexPath(row: 0, section: InterviewSection.overview.rawValue)
        guard let cell = tableView.cellForRow(at: indexPath) as? OverviewTableViewCell else  { return OverviewModel() }
        
        var overview = cell.getOverview()
        
        return overview
    }
     
}
