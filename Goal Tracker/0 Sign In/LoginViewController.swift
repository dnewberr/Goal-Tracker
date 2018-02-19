//
//  LoginViewController.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/18/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    
    let authService = AuthenticationService()
    
    @IBAction func signIn(_ sender: Any) {
        let username = getText(field: usernameTextField, error: usernameErrorLabel)
        let password = getText(field: passwordTextField, error: passwordErrorLabel)
        
        if !username.isEmpty && !password.isEmpty {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getText(field: UITextField, error: UILabel) -> String {
        guard let value = field.text, !value.isEmpty else {
            error.isHidden = false
            return ""
        }
        error.isHidden = true
        return value
    }
}
