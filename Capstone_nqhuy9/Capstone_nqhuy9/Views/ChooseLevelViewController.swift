//
//  ViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//

import UIKit
import RxSwift
import RxCocoa

class ChooseLevelViewController: UIViewController {
    
    @IBOutlet weak var fresherButton:UIButton!
    @IBOutlet weak var juniorButton:UIButton!
    @IBOutlet weak var middleButton:UIButton!
    @IBOutlet weak var seniorButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
    //MARK: -UI
    private func setupUI() {
        self.fresherButton.layer.cornerRadius = 10.0
        self.juniorButton.layer.cornerRadius = 10.0
        self.middleButton.layer.cornerRadius = 10.0
        self.seniorButton.layer.cornerRadius = 10.0
    }
    
    //MARK: -Event
    private func event() {
        
    }
    
    


}

