//
//  SignUpViewController.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/21/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateBorders()
        mainView.layer.borderWidth = 1
        mainView.layer.masksToBounds = false
        mainView.layer.borderColor = UIColor.black.cgColor
        mainView.layer.cornerRadius = mainView.frame.height/2
        mainView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateBorders() {
        self.firstNameField.borderStyle = .none
        self.firstNameField.addBottomBorderWithColor(color: UIColor.black, width: 1, frameWidth: self.mainView.frame.width)
        self.lastNameField.borderStyle = .none
        self.lastNameField.addBottomBorderWithColor(color: UIColor.black, width: 1, frameWidth: self.mainView.frame.width)
        self.emailField.borderStyle = .none
        self.emailField.addBottomBorderWithColor(color: UIColor.black, width: 1, frameWidth: self.mainView.frame.width)
        self.passwordField.borderStyle = .none
        self.passwordField.addBottomBorderWithColor(color: UIColor.black, width: 1, frameWidth: self.mainView.frame.width)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
