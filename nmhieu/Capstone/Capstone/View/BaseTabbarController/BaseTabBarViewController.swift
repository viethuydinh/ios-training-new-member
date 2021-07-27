//
//  BaseTabBarViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 16/07/2021.
//
import UIKit

class BaseTabBarViewController: UITabBarController {

    static let shared = BaseTabBarViewController()
    
    var customTabBar: CustomTabBar!
    
    var tabBarHeight: CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return 80.0
            case .pad:
                return 120.0
            default:
                return .zero
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }

    func loadTabBar() {
        let tabbarItems: [TabItem] = [.home, .history, .sets]

        setUpCustomTabMenu(tabbarItems, completion: { viewControllers in
            self.viewControllers = viewControllers
        })

        selectedIndex = 0
    }

    func setUpCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
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
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
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
