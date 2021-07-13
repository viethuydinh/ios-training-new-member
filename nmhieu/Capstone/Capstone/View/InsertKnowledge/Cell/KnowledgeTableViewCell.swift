//
//  KnowledgeTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import UIKit

class KnowledgeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTF: UITextField!
    
    var knowledgeVM = DefaultKnowledgeViewModel()
    
    func getData() -> QuestionModel? {
        var question : QuestionModel? = QuestionModel()

        if !self.questionTF.text!.isEmpty {
            question?.content = self.questionTF.text
            question?.id = nil
            question?.level = self.knowledgeVM.level
        }
        else {
            return nil
        }
        
        return question
    }
}

extension KnowledgeTableViewCell {
    static let height : CGFloat = 56.0
}
