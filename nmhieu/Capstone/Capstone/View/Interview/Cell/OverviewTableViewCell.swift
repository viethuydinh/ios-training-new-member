//
//  OverviewTableViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 14/07/2021.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overViewTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension OverviewTableViewCell {
    static let height : CGFloat = 300.0
}
