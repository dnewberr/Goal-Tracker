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
            let goalExpirationDate = goalExpirationDatePicker.date
            goalService.createNewGoal(name: goalName, expirationDate: goalExpirationDate, value: goalValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goalService.delegate = self
        setPickerDates()
        clearErrors()
    }

    func setPickerDates() {
        let now = Date()
        self.goalExpirationDatePicker.minimumDate = now
        self.goalExpirationDatePicker.date = Calendar.current.date(byAdding: .month, value: 1, to: now)!
    }
    
    func clearErrors() {
        self.goalNameErrorLabel.isHidden = true
        self.goalValueErrorLabel.isHidden = true
    }
    
    func getText(field: UITextField, error: UILabel) -> String {
        guard let value = field.text, !value.isEmpty else {
            error.isHidden = false
            return ""
        }
        error.isHidden = true
        return value
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /* Delegate Methods */
    func success() {
        performSegue(withIdentifier: "unwindToTableSegue", sender: self)
    }
    
    func failure(message: String) {
        self.present(Utilities.createAlert(message: message), animated: true, completion: nil)
    }
}
