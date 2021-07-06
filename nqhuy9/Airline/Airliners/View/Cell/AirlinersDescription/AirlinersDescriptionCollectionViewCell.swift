//
//  AirlinersDescriptionCollectionViewCell.swift
//  Airliners
//
//  Created by Nghiêm Huy on 6/29/21.
//

import UIKit

class AirlinersDescriptionCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { return "AirlinersDescriptionCollectionViewCell" }
    static var name: String { return self.identifier }
    
    @IBOutlet weak var descriptionLabel : UILabel!
    
    var airplane: Airplane! {
        didSet {
            self.descriptionLabel.text = airplane.infomation.longDescription
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension AirlinersDescriptionCollectionViewCell {
    static func size(bounds : CGRect,content : String) -> CGSize {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16.0)
            label.text = content
            label.numberOfLines = 0
        var size: CGSize = label.sizeThatFits(.init(width: bounds.width - CGFloat.defaultPadding*8, height: .infinity))
            size.height = size.height + CGFloat.defaultPadding*8
            return CGSize(width: bounds.width - CGFloat.defaultPadding*8, height: size.height)

        }
}
