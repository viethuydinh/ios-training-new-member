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
    @IBOutlet weak var shadowView: UIView!
    
    var didEndEditAction : ((Question)->())?
    var didEndEditAction1 : ((String)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.questionTextField.delegate = self
        self.shadowView.addShadow(color: UIColor.black.cgColor, shadowOpacity: 0.5, shadowRadius: 2.0, shadowOffset: CGSize(width: 1.0, height: 1.0))
        self.shadowView.layer.cornerRadius = 10.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.didEndEditAction?(Question(id: nil, content: textField.text, level: nil))
    }
}

extension InsertQuestionTableViewCell {
    static func height() -> CGFloat {
        return 140.0
    }
}
