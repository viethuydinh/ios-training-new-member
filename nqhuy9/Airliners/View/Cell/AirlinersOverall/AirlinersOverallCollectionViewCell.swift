//
//  AirlinersOverallCollectionViewCell.swift
//  Airliners
//
//  Created by Nghiêm Huy on 6/28/21.
//

import UIKit

class AirlinersOverallCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {return "AirlinersOverallCollectionViewCell"}
    static var name: String {return self.identifier}
    
    @IBOutlet weak var modelAirplaneLabel: UILabel!
    @IBOutlet weak var shortInfoLabel : UILabel!
    @IBOutlet weak var imageAirplane : UIImageView!
    
    var airplane: Airplane! {
        didSet {
            modelAirplaneLabel.text = String(airplane.title)
            shortInfoLabel.text = airplane.shortInfo
            imageAirplane.downloaded(from: airplane.image)
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    
    //MARK: -UI
    private func setupUI() {
        self.backgroundColor = .white
        self.imageAirplane.layer.cornerRadius = CGFloat.defaultPadding * 2
        self.layer.cornerRadius = CGFloat.defaultPadding * 2.5
    }

}

extension AirlinersOverallCollectionViewCell {
    static func size(bounds: CGSize) -> CGSize {
        let size = CGSize(width: bounds.width - CGFloat.defaultPadding * 4, height: 100.0)
        return size
    }
}
