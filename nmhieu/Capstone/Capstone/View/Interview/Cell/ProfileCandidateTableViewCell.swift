//
//  ProfileCandidateTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import UIKit

class ProfileCandidateTableViewCell: UITableViewCell {

    @IBOutlet weak var candidateImage: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var jobTitleTF: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    
    func getCandidateInfor() -> InterviewModel {
        var candidateInfor = InterviewModel()
        
        candidateInfor.age = Int(self.ageTF.text ?? "0")
        candidateInfor.name = self.nameTF.text
        candidateInfor.image = self.candidateImage.image
        
        return candidateInfor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }
    
    func setUpUI() {
        
    }
    
    //MARK: -Event
    fileprivate func setUpGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventSignUp))
//       //        self.signUpLabel.isUserInteractionEnabled = true
//       //        self.signUpLabel.addGestureRecognizer(tapGesture)
    }


    //MARK: -BindingData
    func bindingData(level : String) {
        self.levelLabel.text = level
    }

}

extension ProfileCandidateTableViewCell {
    static let height : CGFloat = 160.0 + 32.0
}
