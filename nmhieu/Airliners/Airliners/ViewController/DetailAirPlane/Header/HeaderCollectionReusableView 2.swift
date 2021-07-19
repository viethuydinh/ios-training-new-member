//
//  HeaderCollectionReusableView.swift
//  Airliners
//
//  Created by Nguyễn Minh Hiếu on 30/06/2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    static var identifier : String {return "HeaderCollectionReusableView"}
    static var name : String {return self.identifier}
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension HeaderCollectionReusableView {
    static func size(bounds : CGRect) -> CGSize{
        return CGSize(width: bounds.width - 32, height: 40)
    }
}
