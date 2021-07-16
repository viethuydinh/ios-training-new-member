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
//    case messages = "messages"

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
            return HomeViewController()
//        case .messages:
//            return InboxViewController()
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(named: "hamburger")!
        case .history:
            return UIImage(named: "hamburger")!
        case .profile:
            return UIImage(named: "hamburger")!
//        case .messages:
//            return UIImage(named: "ic_message")!
        }
    }

    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
