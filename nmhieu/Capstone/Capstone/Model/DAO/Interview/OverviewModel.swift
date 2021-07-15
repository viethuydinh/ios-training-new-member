//
//  OverviewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 15/07/2021.
//

import Foundation
import UIKit

struct OverviewModel {
    var content : String?
    var status : StatusInterview?
}

enum StatusInterview : Int {
    case pass = 0
    case fail = 1
    
    var title : String {
        switch self {
        case .pass:
            return "Pass"
        case .fail:
            return "Fail"
        }
    }
    
    var iconStatus : (icon : UIImage?,color :UIColor) {
        switch self {
        case .pass:
            return (icon : UIImage(systemName: "hand.thumbsup.fill"),color :UIColor.appleGreen)
        case .fail:
            return (icon :  UIImage(systemName: "hand.thumbsdown.fill"),color : UIColor.pastelRed)
        }
    }

}
