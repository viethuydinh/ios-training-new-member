//
//  TabBarItem.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 16/07/2021.
//

import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case home = "home"
    case history = "history"
    case profile = "profile"

    var viewController: UIViewController {
        switch self {
        case .home:
            guard let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: HomeViewController.identifier) as? HomeViewController else {
                return UIViewController()
            }
            return homeVC
        case .history:
            guard let historyVC = UIStoryboard(name: "History", bundle: nil).instantiateViewController(withIdentifier: HistoryViewController.identifier) as? HistoryViewController else {
                return UIViewController()
            }
            return historyVC
        case .profile:
            guard let historyVC = UIStoryboard(name: "History", bundle: nil).instantiateViewController(withIdentifier: HistoryViewController.identifier) as? HistoryViewController else {
                return UIViewController()
            }
            return historyVC
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return .home
        case .history:
            return .history
        case .profile:
            return .profile
        }
    }

    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
