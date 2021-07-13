//
//  UIView+Extension.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/13/21.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(color: CGColor, shadowOpacity: Float, shadowRadius: CGFloat, shadowOffset: CGSize){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
    }
}
