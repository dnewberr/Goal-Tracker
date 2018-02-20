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
                self.delegate!.failure(message: self.getErrorMessage(error: error))
            } else {
                self.delegate!.success(data: nil)
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            delegate!.success(data: nil)
        } catch {
            delegate!.failure(message: getErrorMessage(error: error))
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate!.failure(message: self.getErrorMessage(error: error))
            } else {
                self.delegate!.success(data: nil)
            }
        }
    }
    
    func getErrorMessage(error: Error) -> String {
        if let errCode = AuthErrorCode(rawValue: error._code) {
            switch errCode {
                case .wrongPassword:
                    return AuthFailure.wrongEmailPassword
                case .invalidEmail:
                    return AuthFailure.wrongEmailPassword
                case .emailAlreadyInUse:
                    return AuthFailure.emailInUse
                case .keychainError:
                    return AuthFailure.signOut
                default:
                    return AuthFailure.generic
            }
        }
        return AuthFailure.generic
    }
}
