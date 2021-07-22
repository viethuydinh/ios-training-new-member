//
//  QuestionTableViewCell.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/15/21.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    static var identifier : String { "QuestionTableViewCell" }
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel : UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    var question: Question? {
        didSet {
            guard let question = self.question else { return }
            self.contentLabel.text = question.content
            self.levelLabel.text = question.level
            self.correctAnswerLabel.text = question.answer
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    private func setupUI() {
        self.shadowView.addShadow(color: UIColor.black.cgColor, shadowOpacity: 0.5, shadowRadius: 2.0, shadowOffset: CGSize(width: 1.0, height: 1.0))
        self.shadowView.layer.cornerRadius = 10.0
    }
}

extension QuestionTableViewCell {
    static func height(bounds : CGRect,content : String) -> CGFloat {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        label.text = content
        label.numberOfLines = 0
        let size: CGSize = label.sizeThatFits(.init(width: bounds.width - 32.0, height: .infinity))
        return size.height
        }
}
