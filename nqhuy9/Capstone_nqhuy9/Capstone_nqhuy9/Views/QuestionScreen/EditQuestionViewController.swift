//
//  EditQuestionViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 26/07/2021.
//

import UIKit
import RxSwift

class EditQuestionViewController: BaseVC {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var editQuestionViewModel = DefaultKnowledgeViewModel()
    var question: Question?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.saveButton.layer.cornerRadius = 10
        self.setupView(backgroundColor: .white, view: self.answerTextView, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
        self.setupView(backgroundColor: .white, view: self.questionTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
        self.questionTextField.text = self.question?.content
        self.answerTextView.text = self.question?.answer
    }
    
    private func setupView(backgroundColor: UIColor,view: UIView, borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat) {
        view.backgroundColor = backgroundColor
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
        view.layer.cornerRadius = cornerRadius
    }
    
    //MARK: -Event
    private func event() {
        self.eventBack()
        self.eventSave()
    }
    
    private func eventBack() {
        self.backButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                self.navigationController?.popViewController(animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventSave() {
        self.saveButton
            .rx
            .controlEvent(.touchUpInside)
            .subscribe { (_) in
                if self.editQuestionViewModel.editQuestion(question: Question(id: self.question?.id, content: self.questionTextField.text, level: self.question?.level, answer: self.answerTextView.text)) {
                    let dialog = AlertCustomView.init(title: "Success", content: "Edit Question Success", isHiddenCancel: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                    dialog.show(superView: self.view)
                } else {
                    let dialog = AlertCustomView.init(title: "Fail", content: "Edit Question Fail", isHiddenCancel: true) {
                        self.navigationController?.popViewController(animated: true)
                    }
                    dialog.show(superView: self.view)
                }
                NotificationCenter.default.post(name: Notification.Name(NotificationKey.UPDATE_QUESTION), object: nil)
                self.navigationController?.popViewController(animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }


}
