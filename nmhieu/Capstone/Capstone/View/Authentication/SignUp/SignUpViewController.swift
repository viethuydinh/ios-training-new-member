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
    @IBOutlet weak var signInLabel: UILabel!
    
    var authenticationVM = DefaultAuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpGesture()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.signUpBtn.layer.cornerRadius = 10
        self.setUpRegister()
        
    }
    
    fileprivate func setUpRegister() {
        let textSignUp = AccountString.SIGN_IN_TITLE
        let text = String(format: AccountString.DONT_HAVE_ACCOUNT_TITLE, textSignUp)
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor.black,
          .kern: 0.17
        ])
        attributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.niceBlue
        ], range: (text as NSString).range(of: textSignUp))
        self.signInLabel.attributedText = attributedString
    }
    
    //MARK: -Event
    @IBAction func eventSignUp(_ sender: Any) {
        let a = self.authenticationVM.signUp(username: self.userNameTF.text ?? "",
                                              password: self.paswordTF.text ?? "",
                                              repassword: self.confirmPasswordTF.text ?? "")
        print(a)
    }
    
    @objc fileprivate func eventSignIn() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: -Gesture
extension SignUpViewController {
    
    fileprivate func setUpGesture() {
        self.setUpGestureSignInLabel()
    }
    
    fileprivate func setUpGestureSignInLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventSignIn))
        self.signInLabel.isUserInteractionEnabled = true
        self.signInLabel.addGestureRecognizer(tapGesture)
    }
}
