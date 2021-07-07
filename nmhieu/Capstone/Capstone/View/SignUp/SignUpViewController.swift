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
        
    }
    

    @IBAction func eventSignUp(_ sender: Any) {
//        DefaultCoreDataRepo.shared.save(obj: AccountModel(username: self.userNameTF.text, password: self.paswordTF.text, email: self.confirmPasswordTF.text), domain: AccountCoreData())
        DefaultCoreDataRepo.shared.fetchAll(obj: AccountModel(), domain: AccountCoreData())?.forEach({ (acc) in
            print(acc)
        })
//        print(DefaultCoreDataRepo.shared.find(predicate: .init(format: "username = %s", argumentArray: [userNameTF.text]), obj: AccountModel(), domain: AccountCoreData()))
    }
    
}
