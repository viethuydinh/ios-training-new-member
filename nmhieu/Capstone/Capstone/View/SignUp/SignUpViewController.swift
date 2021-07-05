//
//  SignUpViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: BaseVC {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var paswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.even()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.signUpBtn.layer.cornerRadius = 10
    }
    
    //MARK: -Event
    fileprivate func even() {
        self.signUpEvent()
    }
    
    fileprivate func signUpEvent() {
        self.signUpBtn.rx.tap.subscribe(onNext : {
            
        }).disposed(by: self.disposeBag)
    }

}
