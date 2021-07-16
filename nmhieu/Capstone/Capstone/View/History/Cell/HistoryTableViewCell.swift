//
//  HistoryTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 15/07/2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var candidateImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }

    //MARK: -UI
    fileprivate func setUpUI() {
        self.statusView.layer.cornerRadius = 10
    }
    
    //MARK: -BindingData
    func bindingData(data : InterviewModel) {
        self.nameLabel.text = data.candidateInfor?.name
        self.jobTitleLabel.text = data.candidateInfor?.jobTitle
        self.levelLabel.text = data.candidateInfor?.level?.title
        self.candidateImage.image = data.candidateInfor?.image
        self.ageLabel.text = "\(data.candidateInfor?.age ?? 0)"
        self.dateLabel.text = data.date?.string(format: "MMM dd,yyyy") ?? Date.now().string(format: "MMM dd,yyyy")
        self.statusLabel.text = data.overview?.status?.title
        self.statusLabel.backgroundColor = data.overview?.status?.iconStatus.color
    }
}

extension HistoryTableViewCell {
    static func height(_ bounds : CGRect) -> CGFloat {
        return CGFloat(bounds.height/3)
    }
}
