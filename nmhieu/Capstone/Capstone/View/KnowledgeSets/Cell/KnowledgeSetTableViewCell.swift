//
//  KnowledgeSetTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 22/07/2021.
//

import UIKit

class KnowledgeSetTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    func bindingData(knowledge : KnowledgeModel) {
        self.questionLabel.text = knowledge.content
        self.answerLabel.text = knowledge.answer
    }
}

extension KnowledgeSetTableViewCell {
    
    static func height(width : CGFloat, question : String ,answer : String) -> CGFloat {
        let questionLabelHeight = UILabel().size(width: width - 16, content: question, fontSize: 14.0).height
        let answerLabelHeight = UILabel().size(width: width - 16, content: answer, fontSize: 14.0).height
        
        return questionLabelHeight + answerLabelHeight + 120
    }
    
    static let heightHeader : CGFloat = 30.0
    
    static func titleHeader(section : Int) -> String {
        return "Question \(section + 1)"
    }
}


