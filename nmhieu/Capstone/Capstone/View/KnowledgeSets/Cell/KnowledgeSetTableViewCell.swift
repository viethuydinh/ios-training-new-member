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
    
    static var fontSize : CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 14.0
            case .pad :
                return 20.0
            default:
                return .zero
            }
        }
    }
    
    static func height(width : CGFloat, question : String ,answer : String) -> CGFloat {
        let questionLabelHeight = UILabel().size(width: width - 16, content: question, fontSize: self.fontSize).height
        let answerLabelHeight = UILabel().size(width: width - 16, content: answer, fontSize: self.fontSize).height
        
        return questionLabelHeight + answerLabelHeight + 100
    }
    
    static let heightHeader : CGFloat = 30.0
    
    static func titleHeader(section : Int) -> String {
        return "Question \(section + 1)"
    }
}


