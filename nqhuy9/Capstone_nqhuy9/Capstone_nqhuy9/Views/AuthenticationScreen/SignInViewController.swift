//
//  SignInViewController.swift
//  Capstone_nqhuy9
//
//  Created by Nghiêm Huy on 7/2/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class SignInViewController: BaseVC {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var noAccountLabel : UILabel!
    @IBOutlet weak var eyeImage: UIImageView!
    @IBOutlet weak var errorUsernameImage: UIImageView!
    @IBOutlet weak var errorPasswordImage: UIImageView!
    @IBOutlet weak var errorUsernameLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    var isHidePass: Bool = true {
        didSet {
            self.eyeImage.image = isHidePass ? UIImage(named: "eye") : UIImage(named: "invisible")
            self.passwordTextField.isSecureTextEntry = isHidePass
        }
    }
    
    var signInViewModel = DefaultAuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
//MARK: -UI
    private func setupUI() {
        self.setupRegister()
        self.signInButton.layer.cornerRadius = 10.0
        self.setupTextfield(textfield: self.passwordTextField, text: AccountString.PLACEHOLDER_PASSWORD)
        self.setupTextfield(textfield: self.usernameTextField, text: AccountString.PLACEHOLDER_USERNAME)
        self.setupView(backgroundColor: .white, view: self.usernameTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
        self.setupView(backgroundColor: .white, view: self.passwordTextField, borderWidth: 1.0, borderColor: UIColor.gray.cgColor, cornerRadius: 8.0)
    }
    
    private func setupView(backgroundColor: UIColor,view: UIView, borderWidth: CGFloat, borderColor: CGColor, cornerRadius: CGFloat) {
        view.backgroundColor = backgroundColor
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
        view.layer.cornerRadius = cornerRadius
    }
    
    private func setupTextfield(textfield:UITextField,text:String){
        textfield.attributedPlaceholder = NSAttributedString(string: text, attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.textColor = UIColor.lightGray
    }
    
    private func setupRegister() {
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
        self.noAccountLabel.attributedText = attributedString
    }

//MARK: -Event
    private func event() {
        self.eventGoRegister()
        self.eventSignIn()
        self.eventHidePassword()
    }
    
    private func eventSignIn() {
        self.signInButton
            .rx
            .controlEvent(.touchUpInside)
            .do(onNext: { (_) in
                self.view.endEditing(true)
            })
            .withLatestFrom(Observable.combineLatest(self.usernameTextField.rx.text, self.passwordTextField.rx.text))
            .map{ Account(username: $0, password: $1, repassword: nil) }
            .subscribe { (acc) in
                if self.signInViewModel.signIn(account: Account(username: self.usernameTextField.text, password: self.passwordTextField.text, repassword: nil)) {
                    guard let chooseLevelVC = self.getViewControllerFromStorybroad(storybroadName: "Main", identifier: "NavigationMain") as? UINavigationController else { return }
                    self.view.window!.rootViewController = chooseLevelVC
                } else {
                    let dialog = AlertCustomView.init(title: "Fail", content: "Sign In Error", isHiddenCancel: true) {
                        return
                    }
                    dialog.show(superView: self.view)
                }
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventGoRegister() {
        self.noAccountLabel
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe { (_) in
                let signUpVC = self.getViewControllerFromStorybroad(storybroadName: "Authentication", identifier: SignUpViewController.identifier)
                self.navigationController?.pushViewController(signUpVC, animated: true)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }.disposed(by: self.disposeBag)
    }
    
    private func eventHidePassword() {
        self.eyeImage
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
