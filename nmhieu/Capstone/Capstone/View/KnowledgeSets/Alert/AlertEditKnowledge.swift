//
//  AlertEditKnowledge.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 27/07/2021.
//

import UIKit

class AlertEditKnowledge: UIView {

    static let shared = AlertEditKnowledge()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var alertView: UIView!
    @IBOutlet weak var questionTF: UITextField!
    @IBOutlet weak var answerTF: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var editKnowledgeClosure : (KnowledgeModel) -> () = { _ in }
    
    var knowledge : KnowledgeModel? {
        didSet {
            self.questionTF.text = self.knowledge?.content
            self.answerTF.text = self.knowledge?.answer
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertEditKnowledge", owner: self, options: nil)
        self.setUpFrame()
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -UI
    func setUpFrame() {
        self.parentView.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.parentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
    }
    
    func setUpUI() {
        self.alertView.layer.cornerRadius = 20.0
        self.cancelButton.layer.cornerRadius = 20.0
        self.saveButton.layer.cornerRadius = 20.0
        self.questionTF.delegate = self
        self.answerTF.delegate = self
    }
    
    //MARK: -BindingData
    func bindingData(knowledge : KnowledgeModel) {
        self.knowledge = knowledge
        self.showAlert()
    }
    
    //MARK: -Event
    func showAlert() {
        UIApplication.shared.keyWindow?.addSubview(self.parentView)
    }
    
    @IBAction func eventCancel(_ sender: Any) {
        self.parentView.removeFromSuperview()
    }
    
    @IBAction func eventSave(_ sender: Any) {
        self.knowledge?.content = self.questionTF.text
        self.knowledge?.answer = self.answerTF.text
        guard let knowledgeReturn = self.knowledge else { return }
        
        self.editKnowledgeClosure(knowledgeReturn)
        self.parentView.removeFromSuperview()
    }
}

//MARK: -UITextFeildDelegate
extension AlertEditKnowledge : UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if self.questionTF.text?.isEmpty ?? true {
            self.questionTF.text = self.knowledge?.content
        }
        else if self.answerTF.text?.isEmpty ?? true {
            self.answerTF.text = self.knowledge?.answer
        }
        
        return true
    }
}
