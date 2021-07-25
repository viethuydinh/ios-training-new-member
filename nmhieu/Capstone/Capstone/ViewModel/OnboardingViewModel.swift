//
//  OnboardingViewModel.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 19/07/2021.
//

import Foundation
import UIKit

protocol OnboardingViewModel {
    
    var listGifs : [UIImage] { get set }
}

struct DefaultOnboardingViewModel : OnboardingViewModel {
    var listGifs: [UIImage] = [UIImage.gif(name: "InterviewGif1")!,
                               UIImage(named: "InterviewImage2")!,
                               UIImage(named: "InterviewImage3")!]

}
