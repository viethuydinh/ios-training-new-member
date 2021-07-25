//
//  KnowledgeTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 12/07/2021.
//

import UIKit

class KnowledgeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var answerTF: UITextField!
    
    var knowledgeVM = DefaultKnowledgeViewModel()
    
    var knowledgeClosure : (KnowledgeModel) -> () = { _ in }
    
    var indexPath : IndexPath = .init(row: 0, section: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }
    
    //MARK: -UI
    private func setUpUI() {
        self.answerTF.delegate = self
        self.questionTF.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.questionTF.text = ""
        self.answerTF.text = ""
    }
    
    func bindingData(indexPath : IndexPath, listKnowledge : [KnowledgeModel]) {
        self.indexPath = indexPath
        self.questionTF.text = listKnowledge[indexPath.row].content
        self.answerTF.text = listKnowledge[indexPath.row].answer
    }
} 

//MARK: -UITextFeildDelegate
extension KnowledgeTableViewCell : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let beginEditing: [String : Any] = ["beginEditing" : true, "indexPath" : self.indexPath]
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: NSNotification.Name(NotificationKey.enterKnowledge),
                                object: nil,
                                userInfo: beginEditing)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        var knowledge : KnowledgeModel = KnowledgeModel()
        knowledge.content = self.questionTF.text
        knowledge.answer = self.answerTF.text
        self.knowledgeClosure(knowledge)
        return true
    }
}

extension KnowledgeTableViewCell {
    
    static var height : CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 120.0
            case .pad :
                return 240.0
            default:
                return .zero
            }
        }
    }
}
