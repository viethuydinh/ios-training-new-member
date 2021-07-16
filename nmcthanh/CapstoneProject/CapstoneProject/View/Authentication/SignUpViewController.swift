//
//  SignupViewController.swift
//  CapstoneProject
//
//  Created by Thuy on 7/15/21.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    static var identifier: String { return "SignUpViewController" }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(confirmPasswordTextField)
        
        errorLabel.isHidden = true
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        if firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" {
            let alert = UIAlertController(title: "Information", message: "Its mandatory to enter all the fields", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            
        } else if (passwordTextField.text != confirmPasswordTextField.text) {
            let alert = UIAlertController(title: "Information", message: "Password does not match", preferredStyle: .alert)

            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            let newAuthentication = NSEntityDescription.insertNewObject(forEntityName: "Authentication", into: context)

            //Creat a new authentication
            newAuthentication.setValue(emailTextField.text, forKey: "email")
            newAuthentication.setValue(passwordTextField.text, forKey: "password")
            newAuthentication.setValue(confirmPasswordTextField.text, forKey: "confirmPassword")
            
            //Save the data
            do {
                try self.context.save()
            } catch {
                print("There was an error")
            }
            
            //Move back to firstVC
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(identifier: LoginViewController.identifier) as? LoginViewController else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: LoginViewController.identifier) as? LoginViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    

}
