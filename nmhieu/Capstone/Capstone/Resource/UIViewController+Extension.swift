//
//  UIViewController+Extension.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import Foundation
import UIKit

extension UIViewController {

    class var identifier: String { return Self.name }
    
    class var segueIdentifier: String { return "show\(Self.name)" }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
