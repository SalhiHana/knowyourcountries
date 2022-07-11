//
//  ViewController.swift
//  UserApp
//
//  Created by Hana Salhi on 2022-04-25.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet private weak var logoImage: UIImageView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func isValidEmail() -> Bool {
        guard let email = emailTextField.text else { return false }
        if email.isEmpty {return false}
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword() -> Bool {
        guard let password = passwordTF.text else { return false }
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
        
    @IBAction func loginPressed(_ sender: UIButton) {
        let isValidEmail = isValidEmail()
        let isValidPassword = isValidPassword()
        let isValid = isValidEmail && isValidPassword
        print("isValidEmail: \(isValidEmail), isValidPassword: \(isValidPassword)")
        print("isvalid, \(isValid)")
        if !isValidEmail {
            self.presentAlert(message: "Please enter a valid email address.")
        } else if !isValidPassword {
            self.presentAlert(message: "Please enter a valid password.")
        }
        
        if isLoginSuccessfull() {
            showWelcomePage()
        } else {
            presentAlert(message: "Login Failed")
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        
        let isValidEmail = isValidEmail()
        sender.layer.borderWidth = 2
        sender.layer.cornerRadius = 5
        sender.layer.borderColor = (isValidEmail ? UIColor(red: 0.09, green: 0.63, blue: 0.52, alpha: 1.00) : UIColor.red).cgColor
        
    }
    
    @IBAction func passwordFieldEditingChanged(_ sender: UITextField) {
        
        let isValidPassword = isValidPassword()
        sender.layer.borderWidth = 2
        sender.layer.cornerRadius = 5
        sender.layer.borderColor = (isValidPassword ? UIColor(red: 0.09, green: 0.63, blue: 0.52, alpha: 1.00) : UIColor.red).cgColor
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
            let registerViewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
            registerViewController.modalPresentationStyle = .fullScreen
            self.present(registerViewController, animated: true, completion: nil)
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Validation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }

    func isLoginSuccessfull() -> Bool {
        // get emailTextfield text and making it non optional with the guard
        guard let email = emailTextField.text else { return false }
        guard let password = passwordTF.text else { return false }
        let emailObject = realm.object(ofType: User.self, forPrimaryKey: email)
        if let emailObject = emailObject {
            return emailObject.password == password
        }
        return false
    }
    
    func showWelcomePage() {
        UserDefaults.standard.set(true, forKey: SceneDelegate.isLoggedInKey)
        self.dismiss(animated: true, completion: nil)
    }
}

