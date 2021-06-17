//
//  ViewController.swift
//  MyApp
//
//  Created by Thuy on 6/15/21.
//

import UIKit

class ViewController: UIViewController {
    var lightOn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func didTouchedButton(_ sender: Any) {
        lightOn = !lightOn
        updateUI()
    }
    
    func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
    }

}

