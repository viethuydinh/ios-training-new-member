//
//  SignUpViewController.swift
//  Capstone
//
//  Created by Nguyễn Minh Hiếu on 02/07/2021.
//

import UIKit

class SignUpViewController: BaseVC {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    
    var authenticationVM = DefaultAuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.event()
        self.setUpGesture()
    }
    
    //MARK: -UI
    fileprivate func setUpUI() {
        self.signUpButton.layer.cornerRadius = self.signUpButton.bounds.height/2
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
    fileprivate func event() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func eventSignUp(_ sender: Any) {
        let state = self.authenticationVM.signUp(username: self.userNameTF.text ?? "",
                                                 password: self.passwordTF.text ?? "",
                                                 repassword: self.confirmPasswordTF.text ?? "")
        if state.state {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            self.eventAlert(message: state.message)
        }
    }
    
    @objc fileprivate func eventSignIn() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func eventUserName() {
        UIView.animate(withDuration: 0.5) {
            self.userNameTF.isHidden = false
        } completion: { _ in
            self.userNameTF.becomeFirstResponder()
        }
    }
    
    @objc private func eventPassword() {
        UIView.animate(withDuration: 0.5) {
            self.passwordTF.isHidden = false
        } completion: { _ in
            self.passwordTF.becomeFirstResponder()
        }
    }
    
    @objc private func eventConfirmPassword() {
        UIView.animate(withDuration: 0.5) {
            self.confirmPasswordTF.isHidden = false
        } completion: { _ in
            self.confirmPasswordTF.becomeFirstResponder()
        }
    }
    
    deinit {
        print("deinit")
    }
}

//MARK: -Gesture
extension SignUpViewController {
    
    fileprivate func setUpGesture() {
        self.setUpGestureSignInLabel()
        self.setUpGestureUserNameLabel()
        self.setUpGesturePasswordLabel()
        self.setUpGestureConfirmPasswordLabel()
    }
    
    fileprivate func setUpGestureSignInLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventSignIn))
        self.signInLabel.isUserInteractionEnabled = true
        self.signInLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setUpGestureUserNameLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventUserName))
        self.userNameLabel.isUserInteractionEnabled = true
        self.userNameLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setUpGesturePasswordLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventPassword))
        self.passwordLabel.isUserInteractionEnabled = true
        self.passwordLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setUpGestureConfirmPasswordLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eventConfirmPassword))
        self.confirmPasswordLabel.isUserInteractionEnabled = true
        self.confirmPasswordLabel.addGestureRecognizer(tapGesture)
    }
}
