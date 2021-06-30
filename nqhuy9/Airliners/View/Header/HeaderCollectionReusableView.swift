//
//  HeaderCollectionReusableView.swift
//  Airliners
//
//  Created by Nghiêm Huy on 6/30/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static var identifier: String { return "HeaderCollectionReusableView" }
    static var name: String { return self.identifier }
    
    @IBOutlet weak var titleLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
