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
<<<<<<< HEAD
    @IBOutlet weak var statusView: UIView!
=======
>>>>>>> 6190db0 (feat : implement feature history interview)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }

    //MARK: -UI
    fileprivate func setUpUI() {
<<<<<<< HEAD
        self.statusView.layer.cornerRadius = 10
=======
        self.statusLabel.layer.cornerRadius = 10
>>>>>>> 6190db0 (feat : implement feature history interview)
    }
    
    //MARK: -BindingData
    func bindingData(data : InterviewModel) {
        self.nameLabel.text = data.candidateInfor?.name
        self.jobTitleLabel.text = data.candidateInfor?.jobTitle
        self.levelLabel.text = data.candidateInfor?.level?.title
        self.candidateImage.image = data.candidateInfor?.image
<<<<<<< HEAD
        self.ageLabel.text = "\(data.candidateInfor?.age ?? 0)"
        self.dateLabel.text = data.date?.string(format: "MMM dd,yyyy") ?? Date.now().string(format: "MMM dd,yyyy")
=======
        self.ageLabel.text = "\(data.candidateInfor?.age)"
        self.dateLabel.text = "\(data.date)"
>>>>>>> 6190db0 (feat : implement feature history interview)
        self.statusLabel.text = data.overview?.status?.title
        self.statusLabel.backgroundColor = data.overview?.status?.iconStatus.color
    }
}

extension HistoryTableViewCell {
    static func height(_ bounds : CGRect) -> CGFloat {
<<<<<<< HEAD
        return CGFloat(bounds.height - 80.0)/3
=======
        return CGFloat(bounds.height/3)
>>>>>>> 6190db0 (feat : implement feature history interview)
    }
}
