//
//  AirplaneCell.swift
//  AirlinesApp
//
//  Created by Thuy on 6/30/21.
//

import UIKit

class AirplaneCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var imageAirplaneView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func configureContainerView() {
        self.containerView.layer.cornerRadius = 15
    }
}
