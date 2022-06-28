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
        let tabbarItems: [TabItem] = [.level, .question, .review, .level, .question]
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
            setupMiddleButton()
            completion(controllers)
        }
    
    func setupMiddleButton() {
            let middleCircle = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            var menuButtonFrame = middleCircle.frame
            menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 30
            menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
            middleCircle.frame = menuButtonFrame

            middleCircle.backgroundColor = UIColor.red
            middleCircle.layer.cornerRadius = menuButtonFrame.height/2
            
        let itemTitleLabel = UILabel()
        itemTitleLabel.text = "ABC"
        itemTitleLabel.textColor = .black
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true

        let itemImageView = UIImageView()
        itemImageView.image = UIImage(named: "level")?.withRenderingMode(.automatic)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.clipsToBounds = true
        
        middleCircle.addSubview(itemTitleLabel)
        middleCircle.addSubview(itemImageView)

        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(equalToConstant: 25),
            itemImageView.widthAnchor.constraint(equalToConstant: 25),
            itemImageView.centerXAnchor.constraint(equalTo: middleCircle.centerXAnchor),
            itemImageView.topAnchor.constraint(equalTo: middleCircle.topAnchor, constant: 8),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 13),
            itemTitleLabel.widthAnchor.constraint(equalTo: middleCircle.widthAnchor),
            itemTitleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 6),
            itemTitleLabel.centerXAnchor.constraint(equalTo: middleCircle.centerXAnchor)
        ])
        
            view.addSubview(middleCircle)

            view.layoutIfNeeded()
        middleCircle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        changeTab(tab: 2)
    }

    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
