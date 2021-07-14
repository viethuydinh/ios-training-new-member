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
                    print("Sign In Error")
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

}
