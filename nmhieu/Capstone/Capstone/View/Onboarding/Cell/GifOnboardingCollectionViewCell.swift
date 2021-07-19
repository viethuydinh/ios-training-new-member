//
//  GifOnboardingCollectionViewCell.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 19/07/2021.
//

import UIKit

class GifOnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gifImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindingData(gif : UIImage) {
        self.gifImage.image = gif
    }

}

extension GifOnboardingCollectionViewCell {
    static func size(bounds : CGRect) -> CGSize {
        return CGSize(width: bounds.width, height: bounds.height*0.9)
    }
}
