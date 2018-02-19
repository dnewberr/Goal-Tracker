//
//  AlertViewController.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/18/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import Foundation
import UIKit

class AlertViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message = ""
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.addBorder(item: errorLabel)
//        self.addBorder(item: mainView)
//        self.addBorder(item: okayButton)
        
        
        
        
        self.messageLabel.text = message
    }
    
    func addBorder(item: UIView) {
        item.layer.borderColor = UIColor.black.cgColor
        item.layer.borderWidth = 1
        
        
    }
    
    func message(message: String) {
        self.message = message
    }
}
