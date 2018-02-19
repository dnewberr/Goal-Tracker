//
//  Goal.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/17/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import Foundation

class Goal {
    let expiration: Date
    let name: String
    
    init(expiration: Date, name: String) {
        self.expiration = expiration
        self.name = name
    }
}
