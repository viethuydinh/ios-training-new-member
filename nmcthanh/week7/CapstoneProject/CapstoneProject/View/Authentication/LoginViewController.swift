//
//  LoginViewController.swift
//  CapstoneProject
//
//  Created by Thuy on 7/15/21.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    static var identifier: String { return "LoginViewController" }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var result = NSArray()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        errorLabel.isHidden = true
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alert = UIAlertController(title: "Information", message: "Please enter all the fields", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true)
        } else {
            self.CheckForUserNameAndPasswordMatch(email : emailTextField.text! as String, password : passwordTextField.text! as String)
        }
    }
    
    func CheckForUserNameAndPasswordMatch(email: String, password : String) {
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Authentication")
        let predicate = NSPredicate(format: "email = %@", email)

        fetchrequest.predicate = predicate
        do
        {
            result = try context.fetch(fetchrequest) as NSArray

            if result.count > 0 {
                let objectentity = result.firstObject as! Authentication

                if objectentity.email == email && objectentity.password == password {
                    
                    let sb = UIStoryboard.init(name: "Home", bundle: nil)
                    guard let vc = sb.instantiateViewController(identifier: HomeViewController.identifier) as? HomeViewController else { return }
                    navigationController?.pushViewController(vc, animated: true)
                    
                } else {
                    let alert = UIAlertController(title: "Information", message: "User name or password is not valid", preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                    
                    alert.addAction(ok)
                    alert.addAction(cancel)
                    
                    self.present(alert, animated: true)
                }
            }
        }

        catch
        {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: SignUpViewController.identifier) as? SignUpViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
