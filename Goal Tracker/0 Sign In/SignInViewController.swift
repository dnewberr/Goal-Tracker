//
//  LoginViewController.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/18/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController, ServiceDelegate {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    let authService = AuthenticationService()
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBAction func signIn(_ sender: Any) {
        let email = getText(field: emailTextField, error: errorLabel)
        let password = getText(field: passwordTextField, error: errorLabel)
        
        if !email.isEmpty && !password.isEmpty {
            authService.signIn(email: email, password: password)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.authService.delegate = self
        self.generateBorders()
        errorLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "signInSegue", sender: self)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
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
        self.passwordTextField.addBlackBottomBorder()
        self.emailTextField.borderStyle = .none
        self.emailTextField.addBlackBottomBorder()
    }
    
    // Delegate methods
    func success(data: Any?) {
        performSegue(withIdentifier: "signInSegue", sender: self)
    }
    
    func failure(message: String) {
        self.present(Utilities.createAlert(message: message), animated: true, completion: nil)
    }
    
    // closes keyboard on outside touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
