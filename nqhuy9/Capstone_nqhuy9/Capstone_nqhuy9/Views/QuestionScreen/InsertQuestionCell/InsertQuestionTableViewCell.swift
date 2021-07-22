//
//  InsertQuestionTableViewCell.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/13/21.
//

import UIKit

class InsertQuestionTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static var identifier: String { String(describing: self) }
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var shadowView: UIView!
    
    var didEndEditAction : ((Question)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    private func setupUI() {
        self.questionTextField.delegate = self
        self.answerTextField.delegate = self
        self.shadowView.addShadow(color: UIColor.black.cgColor, shadowOpacity: 0.5, shadowRadius: 2.0, shadowOffset: CGSize(width: 1.0, height: 1.0))
        self.shadowView.layer.cornerRadius = 10.0
        self.setupView(backgroundColor: .white, view: self.questionTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
        self.setupView(backgroundColor: .white, view: self.answerTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
    }
    
    private func setupView(backgroundColor: UIColor,view: UIView, borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat) {
        view.backgroundColor = backgroundColor
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
        view.layer.cornerRadius = cornerRadius
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == answerTextField {
            if self.questionTextField.text != "" && self.answerTextField.text != "" {
                self.didEndEditAction?(Question(id: nil, content: self.questionTextField.text, level: nil, answer: self.answerTextField.text))
            }
        }
    }
}

extension InsertQuestionTableViewCell {
    static func height() -> CGFloat {
        return 240.0
    }
}
