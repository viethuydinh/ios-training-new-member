//
//  CandidateInforTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import UIKit

class CandidateInforTableViewCell: UITableViewCell {

    @IBOutlet weak var candidateImage: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var jobTitleTF: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    
    var selectCandidateImage : ((Bool) -> ())?
    var level : LevelInterView = .intern
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpGesture()
    }
    
    func getCandidateInfor() -> CandidateInforModel {
        var candidateInfor = CandidateInforModel()
        candidateInfor.name = self.nameTF.text
        candidateInfor.age = Int(self.ageTF.text ?? "0")
        candidateInfor.image = self.candidateImage.image
        candidateInfor.jobTitle = self.jobTitleTF.text
        candidateInfor.level = self.level
        return candidateInfor
    }
    
    //MARK: -Event
    fileprivate func setUpGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventTapCandidateImage))
        self.candidateImage.isUserInteractionEnabled = true
        self.candidateImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func eventTapCandidateImage() {
        self.selectCandidateImage!(true)
    }

    //MARK: -BindingData
    func bindingData(level : LevelInterView, image : UIImage) {
        self.levelLabel.text = level.title
        self.level = level
        self.candidateImage.image = image
    }
}

extension CandidateInforTableViewCell {
    static var height : CGFloat  {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 160.0 + 32.0
            case .pad :
                return 260.0 + 32.0
            default:
                return .zero
            }
        }
    }
}
