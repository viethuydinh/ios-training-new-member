//
//  ReviewTableViewCell.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/14/21.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    static var identifier : String { "ReviewTableViewCell" }
    
    @IBOutlet weak var candidateNameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!

    var review: Review? {
        didSet {
            guard let review = self.review else { return }
            self.candidateNameLabel.text = review.candidateName
            self.reviewLabel.text = review.content
            self.statusLabel.text = review.status ? "Pass" : "Fail"
            self.statusLabel.textColor = review.status ? .appleGreen : .red
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

extension ReviewTableViewCell {
    static func height(bounds : CGRect,content : String) -> CGFloat {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        label.text = content
        label.numberOfLines = 0
        var size: CGSize = label.sizeThatFits(.init(width: bounds.width - 32.0, height: .infinity))
        size.height = size.height + 140.0
        return size.height
        }
}
