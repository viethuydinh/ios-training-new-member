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
    @IBOutlet weak var noAccountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.event()
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
        self.noAccountLbl.attributedText = attributedString
    }

    //MARK: -Event
    fileprivate func event() {
        self.signInEvent()
        self.signUpEvent()
    }
    
    fileprivate func signInEvent() {
        self.signInBtn.rx.tap.subscribe(onNext: {
            
        }).disposed(by: self.disposeBag)
    }
    
    fileprivate func signUpEvent() {
        self.noAccountLbl.rx.tapGesture().when(.recognized).subscribe { (_) in
            let sb = UIStoryboard.init(name: "SignUp", bundle: nil)
            let vc = sb.instantiateViewController(identifier: SignUpViewController.identifier)
            self.navigationController?.pushViewController(vc, animated: true)
        } onError: { (_) in

        } onCompleted: {

        } onDisposed: {

        }.disposed(by: self.disposeBag)
    }
}
