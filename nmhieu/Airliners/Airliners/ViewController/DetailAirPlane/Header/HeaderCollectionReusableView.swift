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
    
    func configData(_ title : String) {
        self.lblTitle.text = title
    }
}

extension HeaderCollectionReusableView {
    static func size(bounds : CGRect) -> CGSize{
        return CGSize(width: bounds.width - 32, height: 40)
    }
}
