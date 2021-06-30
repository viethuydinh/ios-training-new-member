//
//  DetailCollectionViewCell.swift
//  Airliners
//
//  Created by Nguyễn Minh Hiếu on 30/06/2021.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    static var identifier : String {return "DetailCollectionViewCell"}
    static var name : String {return self.identifier}

    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    var detail : [String:String]? {
        didSet {
            self.bindingData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    fileprivate func bindingData() {
        self.detail!.forEach({ (key,value) in
            self.lblItem.text = key
            self.lblContent.text = value
        })
    }

}

extension DetailCollectionViewCell {
    static func size(bounds : CGRect) -> CGSize {
        return CGSize(width: bounds.width, height: 56)
    }
}
