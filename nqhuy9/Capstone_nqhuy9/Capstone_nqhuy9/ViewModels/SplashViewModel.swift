//
//  SplashViewModel.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/16/21.
//

import Foundation
import UIKit

protocol SplashViewModel {
    var listSplashImage: [UIImage?] { get set }
}

struct DefaultSplashViewModel : SplashViewModel {
    var listSplashImage: [UIImage?] = [UIImage.gif(name: "interview1"), UIImage.gif(name: "interview3")]
}
