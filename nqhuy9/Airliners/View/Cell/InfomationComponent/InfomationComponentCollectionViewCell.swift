//
//  InfomationComponentCollectionViewCell.swift
//  Airliners
//
//  Created by Nghiêm Huy on 6/29/21.
//

import UIKit

class InfomationComponentCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { return "InfomationComponentCollectionViewCell" }
    static var name: String { return self.identifier }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var detail: [String : String]? {
        didSet {
            self.detail?.forEach({ (key,value) in
                self.titleLabel.text = key
                self.contentLabel.text = value
            })
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension InfomationComponentCollectionViewCell {
    static func size(bounds: CGSize) -> CGSize {
        let size = CGSize(width: bounds.width - CGFloat.defaultPadding*2*2, height: 50)
        return size
    }
}
