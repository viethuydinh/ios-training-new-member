//
//  BaseTabBarController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/13/21.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    var customTabBar: CustomTabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }

    func loadTabBar() {
        let tabbarItems: [TabItem] = [.level, .question, .review]
            setupCustomTabMenu(tabbarItems, completion: { viewControllers in
                self.viewControllers = viewControllers
            })
            selectedIndex = 0
        }

    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
            let frame = tabBar.frame
            var controllers = [UIViewController]()
            tabBar.isHidden = true
            customTabBar = CustomTabBar(menuItems: menuItems, frame: frame)
            customTabBar.translatesAutoresizingMaskIntoConstraints = false
            customTabBar.clipsToBounds = true
            customTabBar.itemTapped = changeTab(tab:)
            view.addSubview(customTabBar)
            view.backgroundColor = .white
            NSLayoutConstraint.activate([
                customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
                customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
                customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
                customTabBar.heightAnchor.constraint(equalToConstant: tabBar.frame.height + 32.0),
                customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
            ])
            menuItems.forEach({
                controllers.append($0.viewController)
            })
            view.layoutIfNeeded()
            completion(controllers)
        }

    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
