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
    
    var signUpViewModel = DefaultAuthenticationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.event()
    }
    
//MARK: -UI
    private func setupUI() {
        self.signUpButton.layer.cornerRadius = 10.0
        self.setupSignInLabel()
        self.setupTextfield(textfield: self.usernameTextField, text: AccountString.PLACEHOLDER_USERNAME)
        self.setupTextfield(textfield: self.passwordTextField, text: AccountString.PLACEHOLDER_PASSWORD)
        self.setupTextfield(textfield: self.repasswordTextField, text: AccountString.PLACEHOLDER_RE_PASSWORD)
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

//MARK: -Event
    private func event() {
        self.eventGoSignIn()
        self.eventSignUp()
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
                self.signUpViewModel.signUp(account: acc)
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

}
