//
//  BaseViewController.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit
class BaseViewController: UIViewController,Alertable{
    
var bottomConstraintForKeyboard: NSLayoutConstraint?
/// this function  gets bottom constraint   referance for global bottom constraint
func registerForKeyboardNotifications(bottomConstraint: NSLayoutConstraint) {
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    bottomConstraintForKeyboard = bottomConstraint
}

    /// this function  will change  bottom constraint according to keyboard height
@objc private func keyboardWillShow(notification: Notification) {
    
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        
        if let bottomConstraint = bottomConstraintForKeyboard {
            bottomConstraint.constant = +keyboardSize.height

            self.view.layoutIfNeeded()
        }
    }
    
}
    /// this function  will change  bottom constraint to 0
@objc private func keyboardWillHide(notification: Notification) {
    if let bottomConstraint = bottomConstraintForKeyboard {
        bottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
}
}
