//
//  QuestionTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rateAnswerButton: UIButton!
    
    var status : RateAnswer = .good
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }
    
    func getQuestion() -> QuestionInterviewModel {
        var question = QuestionInterviewModel()
        question.id = nil
        question.question = self.questionLabel.text
        question.rate = self.status
        return question
    }
    
    func setUpUI() {
        self.rateAnswerButton.layer.cornerRadius = 10
    }
    
    @IBAction func eventRateAnswer(_ sender: Any) {
        switch status {
        case .good:
            status = .nomal
            self.rateAnswerButton.backgroundColor = .blue
        case .nomal:
            status = .bad
            self.rateAnswerButton.backgroundColor = .pastelRed
        case .bad:
            status = .good
            self.rateAnswerButton.backgroundColor = .appleGreen
        }
        self.rateAnswerButton.setTitle(status.title, for: .normal)
    }
    
    //MARK: -BindingData
    func bindingData(question : String) {
        self.questionLabel.text = question
    }
}

extension QuestionTableViewCell {
    
    static var height : CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
               return 56.0
            case .pad :
               return 80.0
            default:
               return .zero
            }
        }
    }
}
