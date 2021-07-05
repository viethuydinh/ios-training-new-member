//
//  AirLineCollectionViewCell.swift
//  Airliners
//
//  Created by Nguyễn Minh Hiếu on 28/06/2021.
//

import UIKit

class AirLineCollectionViewCell: UICollectionViewCell {
    
    static var identifier : String {return "AirLineCollectionViewCell"}
    static var name : String {return self.identifier}
    
    @IBOutlet weak var lblTitleAirplane: UILabel!
    @IBOutlet weak var lblInforAirplane: UILabel!
    @IBOutlet weak var imgAirplane: UIImageView!
    
    var airplane : Airplane? {
        didSet {
            self.bindingData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
    }
    
    fileprivate func setUpUI() {
        self.imgAirplane.layer.cornerRadius = 7
        self.layer.cornerRadius = 7
    }
    
    private func bindingData() {
        self.lblTitleAirplane.text = self.airplane!.title
        self.lblInforAirplane.text = self.airplane!.shortInfor
        self.imgAirplane.downloaded(from: self.airplane!.image!)
    }
}

extension AirLineCollectionViewCell {
    static func size(bound : CGRect) -> CGSize {
        return CGSize(width: bound.width - lineSpace*2, height: bound.height*0.11)
    }
    
    static let lineSpace :CGFloat = 10
}
