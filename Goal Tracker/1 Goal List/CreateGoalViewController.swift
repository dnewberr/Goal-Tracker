//
//  CreateGoalViewController.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/18/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController, ServiceDelegate {
    @IBOutlet weak var goalExpirationDatePicker: UIDatePicker!
    @IBOutlet weak var goalNameTextField: UITextField!
    @IBOutlet weak var goalNameErrorLabel: UILabel!
    @IBOutlet weak var goalValueTextField: UITextField!
    @IBOutlet weak var goalValueErrorLabel: UILabel!
    
    let goalService = GoalService()
    
    @IBAction func saveGoal(_ sender: Any) {
        let goalName = getText(field: goalNameTextField, error: goalNameErrorLabel)
        let goalValue = getText(field: goalValueTextField, error: goalValueErrorLabel)
        
        if !goalName.isEmpty && !goalValue.isEmpty {
            let expirationDate = goalExpirationDatePicker.date
            let value = (goalValue as NSString).doubleValue
            goalService.createNewGoal(name: goalName, expirationDate: expirationDate, value: value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearErrors()
        self.generateBorders()
        self.setPickerDates()
    }
    
    func clearErrors() {
        self.goalNameErrorLabel.isHidden = true
        self.goalValueErrorLabel.isHidden = true
    }
    
    func generateBorders() {
        self.goalService.delegate = self
        self.goalNameTextField.borderStyle = .none
        self.goalNameTextField.addBlackBottomBorder()
        self.goalValueTextField.borderStyle = .none
        self.goalValueTextField.addBlackBottomBorder()
    }
    
    func getText(field: UITextField, error: UILabel) -> String {
        guard let value = field.text, !value.isEmpty else {
            error.isHidden = false
            return ""
        }
        error.isHidden = true
        return value
    }

    func setPickerDates() {
        let now = Date()
        self.goalExpirationDatePicker.minimumDate = now
        self.goalExpirationDatePicker.date = Calendar.current.date(byAdding: .month, value: 1, to: now)!
    }
    
    // Delegate Methods
    func success(data: Any?) {
        performSegue(withIdentifier: "unwindToTableSegue", sender: self)
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
