//
//  HomeViewController.swift
//  CapstoneProject
//
//  Created by Thuy on 7/16/21.
//

import UIKit

class HomeViewController: UIViewController {
    static var identifier: String { return "HomeViewController" }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
}
