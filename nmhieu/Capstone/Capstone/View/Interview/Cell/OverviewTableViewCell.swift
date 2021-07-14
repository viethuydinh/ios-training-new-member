//
//  OverviewTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overViewTextView: UITextView!
<<<<<<< HEAD
    @IBOutlet weak var statusImage: UIImageView!
    
    var status : StatusInterview = .pass
    var editingOverviewTextview : ((Bool) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
        self.setUpGesture()
    }
    
    //MARK: -UI
    private func setUpUI() {
        self.overViewTextView.delegate = self
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
    
    private func beginEditingTextView(statusEdit : Bool) {
        if statusEdit {
            if self.overViewTextView.text == "Overview" {
                self.overViewTextView.text = ""
            }
            self.overViewTextView.textColor = .navy
        }
        else {
            self.overViewTextView.text = "Overview"
            self.overViewTextView.textColor = .lightGray
        }
    }
}

extension OverviewTableViewCell : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.editingOverviewTextview?(true)
        self.beginEditingTextView(statusEdit: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.beginEditingTextView(statusEdit: !self.overViewTextView.text.isEmpty)
    }
=======
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
>>>>>>> 0daedd9 (feat : implement Interview feature (UIInterview , logic interview in InterviewViewModel ))
}

extension OverviewTableViewCell {
    static let height : CGFloat = 300.0
}
