//
//  LoginViewController.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/18/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, ServiceDelegate {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    let authService = AuthenticationService()
    
    @IBAction func signIn(_ sender: Any) {
        let email = getText(field: emailTextField, error: errorLabel)
        let password = getText(field: emailTextField, error: errorLabel)
        
        if !email.isEmpty && !password.isEmpty {
            authService.signIn(email: email, password: password)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.authService.delegate = self
        self.generateBorders()
        errorLabel.isHidden = true
        let keyboardDismissTap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        view.addGestureRecognizer(keyboardDismissTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getText(field: UITextField, error: UILabel) -> String {
        guard let value = field.text, !value.isEmpty else {
            error.isHidden = false
            return ""
        }
        error.isHidden = true
        return value
    }
    func generateBorders() {
        self.passwordTextField.borderStyle = .none
        self.passwordTextField.addBottomBorderWithColor(color: UIColor.black, width: 1.0)
        self.emailTextField.borderStyle = .none
        self.emailTextField.addBottomBorderWithColor(color: UIColor.black, width: 1.0)
    }
    
    // Delegate methods
    func success() {
        performSegue(withIdentifier: "singInSegue", sender: self)
    }
    
    func failure(message: String) {
        self.present(Utilities.createAlert(message: message), animated: true, completion: nil)
    }
}
