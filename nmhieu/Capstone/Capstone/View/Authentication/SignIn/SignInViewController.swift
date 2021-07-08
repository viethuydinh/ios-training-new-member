//
//  SignInViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import UIKit
import RxSwift
import RxGesture

class SignInViewController: BaseVC {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    
    var authenticationVM = DefaultAuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpGesture()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.signInBtn.layer.cornerRadius = 10
        self.setUpRegister()
    }
    
    fileprivate func setUpRegister() {
        let textSignUp = AccountString.SIGN_UP_TITLE
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
        self.signUpLabel.attributedText = attributedString
    }

    //MARK: -Event
    @IBAction func signInEvent() {
        let a = self.authenticationVM.signIn(username: self.userNameTF.text ?? "",
                                              password: self.passwordTF.text ?? "")
        print(a)
    }
    
    @objc fileprivate func eventSignUp() {
        let sb = UIStoryboard.init(name: "SignUp", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: SignUpViewController.identifier) as? SignUpViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -Gesture
extension SignInViewController {
    
    fileprivate func setUpGesture() {
        self.setUpGestureSignInLabel()
    }
    
    fileprivate func setUpGestureSignInLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventSignUp))
        self.signUpLabel.isUserInteractionEnabled = true
        self.signUpLabel.addGestureRecognizer(tapGesture)
    }
}

