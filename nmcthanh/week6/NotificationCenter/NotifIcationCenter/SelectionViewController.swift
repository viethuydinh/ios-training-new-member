//
//  SelectionViewController.swift
//  NotifycationCenter
//
//  Created by Thuy on 7/13/21.
//

import UIKit
struct NotificationName {
    static let darkNotification = "darkSide"
    static let lightNotification = "lightSide"
}
class SelectionViewController: UIViewController {
    
    static var identifier : String { return "SelectionViewController" }
    
    static var name : String { return self.identifier }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func chooseImperial(_ sender: UIButton) {
        let name = Notification.Name(rawValue: NotificationName.darkNotification)
        NotificationCenter.default.post(name: name, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseRebel(_ sender: UIButton) {
        let name = Notification.Name(rawValue: NotificationName.lightNotification)
        NotificationCenter.default.post(name: name, object: nil)
        dismiss(animated: true, completion: nil)
    }
}


