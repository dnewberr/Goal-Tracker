//
//  Goal.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/17/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import Foundation
import Firebase

class Goal {
    let id: String
    let expiration: Date
    let name: String
    
    init(snapshot: QueryDocumentSnapshot) {
        self.id = snapshot.documentID
        
        let data = snapshot.data()
        if let expirationDate = data["expirationDate"] as? Date {
            self.expiration = expirationDate
        } else {
            self.expiration = Date()
        }
        
        if let goalName = data["name"] as? String {
            self.name = goalName
        } else {
            self.name = ""
        }
    }
}
