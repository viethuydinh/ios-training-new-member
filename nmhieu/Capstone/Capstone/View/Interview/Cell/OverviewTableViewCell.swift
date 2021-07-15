//
//  OverviewTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var statusImage: UIImageView!
    
    var status : StatusInterview = .pass
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpGesture()
    }
    
    func getOverview() -> OverviewModel {
        var overview = OverviewModel()
        overview.content = self.overViewTextView.text
        overview.status = self.status
        return overview
    }
    
    //MARK: -Event
    fileprivate func setUpGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventTapChangeStatus))
        self.statusImage.isUserInteractionEnabled = true
        self.statusImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func eventTapChangeStatus() {
        switch self.status {
        case .pass:
            self.status = .fail
        case .fail:
            self.status = .pass
        }
        self.statusImage.image = self.status.iconStatus.icon
        self.statusImage.tintColor = self.status.iconStatus.color
    }
}

extension OverviewTableViewCell {
    static let height : CGFloat = 300.0
}
