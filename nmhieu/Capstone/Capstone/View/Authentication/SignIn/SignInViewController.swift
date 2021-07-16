//
//  SignInViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import UIKit

class SignInViewController: BaseVC {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    
    var authenticationVM = DefaultAuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.event()
        self.setUpGesture()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.signInButton.layer.cornerRadius = 10
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
    fileprivate func event() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func eventSignIn() {
        let stateAuth = self.authenticationVM.signIn(username: self.userNameTF.text ?? "",
                                              password: self.passwordTF.text ?? "")
        if stateAuth.state {
            guard let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "NavigationMain") as? UINavigationController else { return }
            self.view.window?.rootViewController = vc
        }
        else {
            self.eventAlert(message: stateAuth.message)
        }
    }
    
    @objc fileprivate func eventSignUp() {
        guard let vc = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(identifier: SignUpViewController.identifier) as? SignUpViewController else { return }
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


