//
//  KnowledgeTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import UIKit

class KnowledgeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var answer1TF: UITextField!
    @IBOutlet weak var answer2TF: UITextField!
    @IBOutlet weak var answer3TF: UITextField!
    
    var knowledgeVM = DefaultKnowledgeViewModel()
    
    var knowledge : KnowledgeModel? {
        didSet {
            self.knowledge?.question?.content = self.questionTF.text
            self.knowledge?.question?.id = nil
            self.knowledge?.question?.level = self.knowledgeVM.level
            var listAnswers : [AnswerModel] = []
            listAnswers.append(AnswerModel(id: 0, content: self.answer1TF.text, accuracy: true))
            listAnswers.append(AnswerModel(id: 0, content: self.answer2TF.text, accuracy: true))
            listAnswers.append(AnswerModel(id: 0, content: self.answer3TF.text, accuracy: true))
            self.knowledge?.answers = listAnswers
        }
    }
    
    func bindingData() {
        if self.detectViewEndediting() {
            
        }
        self.knowledgeVM.knowledge
    }
    
    func detectViewEndediting() -> Bool {
        return self.contentView.endEditing(true)
    }
}

extension KnowledgeTableViewCell {
    static let height : CGFloat = 56.0*4 + 10.0*3
}
