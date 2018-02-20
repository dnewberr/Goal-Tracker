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
    
    func fetchGoals() {
        goalsCollection.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.delegate!.failure(message: "ew")
            } else {
                var goals = [Goal]()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    goals.append(Goal(snapshot: document))
                }
                self.delegate!.success(data: goals)
            }
        }
    }
    
    func deleteGoal(id: String, newGoals: [Goal]) {
        goalsCollection.document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                self.delegate!.failure(message: "nope can't delete")
            } else {
                self.delegate!.success(data: newGoals)
            }
        }
    }
    
    func createNewGoal(name: String, expirationDate: Date, value: Double) {
        goalsCollection.addDocument(data: [
            "name": name.lowercased(),
            "expirationDate": expirationDate,
            "value": value
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                self.delegate!.failure(message: "failure saving goal, please try again later.")
            } else {
                self.delegate!.success(data: nil)
            }
        }
    }
}
