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
    
    var knowledgeClosure : ((KnowledgeModel) -> ())?
    
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

    func getKnowlege() -> KnowledgeModel? {
        var question : KnowledgeModel? = KnowledgeModel()
        if (self.questionTF.text?.isEmpty ?? false) && (self.answerTF.text?.isEmpty ?? false) {
            question?.content = self.questionTF.text
            question?.answer  = self.answerTF.text
            question?.id = nil
            question?.level = self.knowledgeVM.level
        }
        else {
            return nil
        }
        return question
    }
    
    func bindingData(indexPath : IndexPath) {
        self.indexPath = indexPath
    }
} 

extension KnowledgeTableViewCell : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let knowledge = self.getKnowlege() else { return }
        self.knowledgeClosure?(knowledge)
        
        let beginEditing  : [String : Any] = ["beginEditing" : false, "indexPath" : self.indexPath]
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: NSNotification.Name(NotificationKey.enterKnowledge),
                                object: nil,
                                userInfo: beginEditing)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let beginEditing: [String : Any] = ["beginEditing" : true, "indexPath" : self.indexPath]
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: NSNotification.Name(NotificationKey.enterKnowledge),
                                object: nil,
                                userInfo: beginEditing)
    }
}

extension KnowledgeTableViewCell {
    static let height : CGFloat = 120.0
}
