//
//  Utilities.swift
//  Goal Tracker
//
//  Created by Deborah Newberry on 2/18/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//

import Foundation
import UIKit

public protocol ServiceDelegate: class {
    func failure(message: String)
    func success(data: Any?)
}

class Utilities {
    static func createAlert(message: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "alert") as! AlertViewController
        myAlert.message(message: message)
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        return myAlert
    }
    
    static func convertStringToDate(date: String) -> Date {
        // TODO
        return Date()
    }
}

struct AuthFailure {
    static let emailInUse = "email already in use."
    static let generic = "something went wrong, please try again later."
    static let signOut = "failed to sign out, please try again later."
    static let wrongEmailPassword = "wrong email and password combination."
}

extension UIView {
    func addBlackTopBorder() { addTopBorderWithColor(color: UIColor.black, width: 1) }
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addBlackRightBorder() { addRightBorderWithColor(color: UIColor.black, width: 1) }
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: visualWidth() + width * 2, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBlackBottomBorder() { addBottomBorderWithColor(color: UIColor.black, width: 1, frameWidth: UIScreen.main.bounds.width) }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat, frameWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: -self.frame.minX, y: self.frame.size.height - width, width: frameWidth, height: width)
        self.layer.addSublayer(border)
    }
    
    func addBlackLeftBorder() { addLeftBorderWithColor(color: UIColor.black, width: 1) }
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func visualWidth() -> CGFloat {
        return self.frame.size.width + self.frame.minX
    }
}
