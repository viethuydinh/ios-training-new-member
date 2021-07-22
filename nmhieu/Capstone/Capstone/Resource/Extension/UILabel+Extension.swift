//
//  UILabel+Extension.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 22/07/2021.
//

import Foundation
import UIKit

extension UILabel {
    
    func size(width : CGFloat, content : String , fontSize : CGFloat) -> CGSize {
        self.font = .systemFont(ofSize: fontSize)
        self.text = content
        self.numberOfLines = 0
        let size : CGSize = self.sizeThatFits(.init(width: width , height: .infinity))
        return size
    }
}
