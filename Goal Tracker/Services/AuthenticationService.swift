//
//  LoginService.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/18/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import Foundation
import FirebaseAuth

public class AuthenticationService {
    weak var delegate: ServiceDelegate?
    let auth = Auth.auth()
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate!.failure(message: "Failed to sign in. Please try again later.")
                print("Error signing in: \(error)")
            } else {
                self.delegate!.success()
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            delegate!.success()
        } catch {
            delegate?.failure(message: "Failed to sign out. Please try again later.")
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate?.failure(message: "Failed to sign up. Please try again later.")
                print("Error signing up: \(error)")
            } else {
                self.delegate!.success()
            }
        }
    }
}
