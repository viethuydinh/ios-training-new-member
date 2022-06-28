//
//  SignUpViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: BaseVC {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var haveAccountLabel : UILabel!
    @IBOutlet weak var eyePasswordImage : UIImageView!
    @IBOutlet weak var eyeRePasswordImage : UIImageView!
    @IBOutlet weak var errorUsernameImage: UIImageView!
    @IBOutlet weak var errorPasswordImage: UIImageView!
    @IBOutlet weak var errorRePasswordImage: UIImageView!
    @IBOutlet weak var errorUsernameLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    @IBOutlet weak var errorRePasswordLabel: UILabel!
    
    
    var signUpViewModel = DefaultAuthenticationViewModel()
    
    var isHidePass: Bool = true {
        didSet {
            self.eyePasswordImage.image = isHidePass ? UIImage(named: "eye") : UIImage(named: "invisible")
            self.eyeRePasswordImage.image = isHidePass ? UIImage(named: "eye") : UIImage(named: "invisible")
            self.passwordTextField.isSecureTextEntry = isHidePass
            self.repasswordTextField.isSecureTextEntry = isHidePass
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
//MARK: -UI
    private func setupUI() {
        self.signUpButton.layer.cornerRadius = 10.0
        self.setupSignInLabel()
        self.setupError()
        self.setupHiddenError()
        self.setupTextfield(textfield: self.usernameTextField, text: AccountString.PLACEHOLDER_USERNAME)
        self.setupTextfield(textfield: self.passwordTextField, text: AccountString.PLACEHOLDER_PASSWORD)
        self.setupTextfield(textfield: self.repasswordTextField, text: AccountString.PLACEHOLDER_RE_PASSWORD)
        self.setupView(backgroundColor: .white, view: self.usernameTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
        self.setupView(backgroundColor: .white, view: self.passwordTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
        self.setupView(backgroundColor: .white, view: self.repasswordTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
    }
    
    private func setupHiddenError() {
        self.errorUsernameLabel.isHidden = true
        self.errorPasswordLabel.isHidden = true
        self.errorUsernameImage.isHidden = true
        self.errorPasswordImage.isHidden = true
        self.errorRePasswordImage.isHidden = true
        self.errorRePasswordLabel.isHidden = true
    }
    
    private func setupView(backgroundColor: UIColor,view: UIView, borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat) {
        view.backgroundColor = backgroundColor
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
        view.layer.cornerRadius = cornerRadius
    }
    
    private func setupTextfield(textfield:UITextField,text:String) {
        textfield.attributedPlaceholder = NSAttributedString(string: text, attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.textColor = UIColor.lightGray
    }
    
    private func setupSignInLabel() {
        let textSignUp = AccountString.SIGN_IN_TITLE
        let text = String(format: AccountString.HAVE_ACCOUNT_TITLE, textSignUp)
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor.black,
          .kern: 0.17
        ])
        
        attributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.niceBlue
        ], range: (text as NSString).range(of: textSignUp))
        self.haveAccountLabel.attributedText = attributedString
    }
    
    private func setupError() {
        self.setupErrorUsername()
        self.setupErrorPassword()
        self.setupErrorRePassword()
    }
    
    private func setupErrorUsername() {
        self.usernameTextField.addTarget(self, action: #selector(checkErrorUsername), for: .editingDidEnd)
    }
    
    @objc func checkErrorUsername() {
        self.errorUsernameLabel.isHidden = self.signUpViewModel.emailValidate(email: self.usernameTextField.text)
        self.errorUsernameImage.isHidden = self.signUpViewModel.emailValidate(email: self.usernameTextField.text)
    }
    
    private func setupErrorPassword() {
        self.passwordTextField.addTarget(self, action: #selector(checkErrorPassword), for: .editingDidEnd)
    }
    
    @objc func checkErrorPassword() {
        self.errorPasswordLabel.isHidden = self.signUpViewModel.passwordValidate(password: self.passwordTextField.text)
        self.errorPasswordImage.isHidden = self.signUpViewModel.passwordValidate(password: self.passwordTextField.text)
    }
    
    private func setupErrorRePassword() {
        self.repasswordTextField.addTarget(self, action: #selector(checkErrorRePassword), for: .editingDidEnd)
    }
    
    @objc func checkErrorRePassword() {
        self.errorRePasswordImage.isHidden = self.signUpViewModel.repasswordValidate(password: self.passwordTextField.text, repassword: self.repasswordTextField.text)
        self.errorRePasswordLabel.isHidden = self.signUpViewModel.repasswordValidate(password: self.passwordTextField.text, repassword: self.repasswordTextField.text)
    }

//MARK: -Event
    private func event() {
        self.eventGoSignIn()
        self.eventSignUp()
        self.eventHidePassword()
        self.eventHideRePassword()
    }
    
    private func eventSignUp() {
        self.signUpButton
            .rx
            .controlEvent(.touchUpInside)
            .do(onNext: { (_) in
                self.view.endEditing(true)
            })
            .withLatestFrom(Observable.combineLatest(self.usernameTextField.rx.text, self.passwordTextField.rx.text, self.repasswordTextField.rx.text))
            
            .map { Account(username: $0, password: $1, repassword: $2) }
            .subscribe(onNext: { (acc) in
                if self.signUpViewModel.signUp(account: acc) {
                    let dialog = AlertCustomView.init(title: "Successful", content: "You have done your signing up", isHiddenCancel: true) {
                        guard let signInVC = self.getViewControllerFromStorybroad(storybroadName: "Authentication", identifier: SignInViewController.identifier) as? SignInViewController else { return }
                        self.navigationController?.pushViewController(signInVC, animated: true)
                    }
                    dialog.show(superView: self.view)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func eventGoSignIn() {
        self.haveAccountLabel
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe { (_) in
                guard let signInVC = self.getViewControllerFromStorybroad(storybroadName: "Authentication", identifier: SignInViewController.identifier) as? SignInViewController else { return }
                self.navigationController?.pushViewController(signInVC, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventHidePassword() {
        self.eyePasswordImage
            .rx
            .tapGesture()
            .subscribe { _ in
                self.isHidePass = !self.isHidePass
            } onError: { _ in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }
    
    private func eventHideRePassword() {
        self.eyeRePasswordImage
            .rx
            .tapGesture()
            .subscribe { _ in
                self.isHidePass = !self.isHidePass
            } onError: { _ in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)

    }

}
