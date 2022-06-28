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
    
    func configureCell(list: [Airplane], indexPath: IndexPath) {
        nameLabel.text = list[indexPath.row].name
        overviewLabel.text = list[indexPath.row].overview
        imageAirplaneView?.image = UIImage(named: "\(list[indexPath.row].imageName ?? "")")
    }
    
    func configureContainerView() {
        self.containerView.layer.cornerRadius = 15
    }
}
