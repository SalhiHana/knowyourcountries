//
//  RegisterView.swift
//  UserApp
//
//  Created by Hana Salhi on 2022-05-12.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {
    
    
    let realm = try! Realm() 
    
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var rewritePasswordTextField: UITextField!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")        
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
    
    func isValidRewritePassword() -> Bool {
        guard let rewritePasswordText = rewritePasswordTextField.text else { return false }
        guard let passwordText = passwordTF.text else { return false }
        return rewritePasswordText == passwordText
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let isValidEmail = isValidEmail()
        let isValidPassword = isValidPassword()
        let isValid = isValidEmail && isValidPassword
        print("isValidEmail: \(isValidEmail), isValidPassword: \(isValidPassword)")
        print("isvalid, \(isValid)")
        
        if !isValidEmail {
            self.presentAlert(message: "Please enter a valid email address.")
        } else if !isValidPassword {
            self.presentAlert(message: "Please enter a password.")
        } else if !isValidRewritePassword() {
            self.presentAlert(message: "Please rewrite the similar password.")
        }
        
        let user = User()
        user.email = emailTextField.text ?? ""
        user.password = passwordTF.text ?? ""
        if !emailAlreadyExists() {
            save(data: user)
        } else {
            presentAlert(message: "Email Already Exists, Please choose another one! ")
        }
    }
    
    
    @IBAction func emailTextEditingChanged(_ sender: UITextField) {
        let isValidEmail = isValidEmail()
        var textColor = UIColor.red
        
        if isValidEmail {
            textColor = UIColor(red: 0.09, green: 0.63, blue: 0.52, alpha: 1.00)
        } else {
            textColor = .red
        }
        
        let attributedText = NSMutableAttributedString(attributedString: sender.attributedText!)
        attributedText.setAttributes([NSAttributedString.Key.foregroundColor : textColor], range: NSMakeRange(0, attributedText.length))
        sender.attributedText = attributedText
    }
    
    @IBAction func passwordTextEditingChanged(_ sender: UITextField) {
        let isValidPassword = isValidPassword()
        var textColor = UIColor.red
        
        if isValidPassword {
            textColor = UIColor(red: 0.09, green: 0.63, blue: 0.52, alpha: 1.00)
        } else {
            textColor = .red
        }
        
        let attributedText = NSMutableAttributedString(attributedString: sender.attributedText!)
        attributedText.setAttributes([NSAttributedString.Key.foregroundColor : textColor], range: NSMakeRange(0, attributedText.length))
        sender.attributedText = attributedText
    }

    @IBAction func rewritePasswordTextEditingChanged(_ sender: UITextField) {
       let isValidRewritePassword = isValidRewritePassword()
       var textColor = UIColor.red
       
       if isValidRewritePassword {
           textColor = UIColor(red: 0.09, green: 0.63, blue: 0.52, alpha: 1.00)
       } else {
           textColor = .red
       }
       
       let attributedText = NSMutableAttributedString(attributedString: sender.attributedText!)
       attributedText.setAttributes([NSAttributedString.Key.foregroundColor : textColor], range: NSMakeRange(0, attributedText.length))
       sender.attributedText = attributedText
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
       
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    func save(data: User) {
        
        do{
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error saving data, \(error)")
        }
    }
   
    func emailAlreadyExists() -> Bool {
        // get emailTextfield text and making it non optional with the guard
        guard let email = emailTextField.text else { return false }
        // 
        let emailObject = realm.object(ofType: User.self, forPrimaryKey: email)
        return emailObject != nil
    }
}

