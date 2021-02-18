//
//  BaseViewController.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit
class BaseViewController: UIViewController{
    
var bottomConstraintForKeyboard: NSLayoutConstraint?

func registerForKeyboardNotifications(bottomConstraint: NSLayoutConstraint) {
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    bottomConstraintForKeyboard = bottomConstraint
}

@objc private func keyboardWillShow(notification: Notification) {
    
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        
        if let bottomConstraint = bottomConstraintForKeyboard {
            bottomConstraint.constant = +keyboardSize.height

            self.view.layoutIfNeeded()
        }
    }
    
}

@objc private func keyboardWillHide(notification: Notification) {
    if let bottomConstraint = bottomConstraintForKeyboard {
        bottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
}
}
