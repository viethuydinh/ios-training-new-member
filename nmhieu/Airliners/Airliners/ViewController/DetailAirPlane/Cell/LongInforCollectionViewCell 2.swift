//
//  LongInforCollectionViewCell.swift
//  Airliners
//
//  Created by Nguyễn Minh Hiếu on 29/06/2021.
//

import UIKit

class LongInforCollectionViewCell: UICollectionViewCell {

    static var identifier : String {return "LongInforCollectionViewCell"}
    static var name : String {return self.identifier}
    
    @IBOutlet weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension LongInforCollectionViewCell {
    static func size(bounds : CGRect,content : String) -> CGSize {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.text = content
        label.numberOfLines = 0
        var size: CGSize = label.sizeThatFits(.init(width: bounds.width - 32, height: .infinity))
        return CGSize(width: bounds.width, height: size.height)
    }

}
