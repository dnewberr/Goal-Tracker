//
//  GoalService.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/17/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import Foundation
import Firebase

public class GoalService {
    weak var delegate: ServiceDelegate?
    let goalsCollection = Firestore.firestore().collection("goals")
    
    func createNewGoal(name: String, expirationDate: Date, value: String) {
        goalsCollection.addDocument(data: [
            "name": name,
            "expirationDate": expirationDate,
            "value": value
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                self.delegate!.failure(message: "Failure saving goal. Please try again later.")
            } else {
                self.delegate!.success()
            }
        }
    }
}
