//
//  SplashCollectionViewCell.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/16/21.
//

import UIKit

class SplashCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { return "SplashCollectionViewCell" }
    
    @IBOutlet weak var imageSplash: UIImageView!
    
    var isDefaultSize: Bool = true
    
    var size: CGSize = .zero {
        didSet {
            self.isDefaultSize = false
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        if !self.isDefaultSize {
            attributes.frame.size = self.size
        }
        return attributes
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SplashCollectionViewCell {
    static func size(bounds : CGSize) -> CGSize {
        return bounds
    }
}
