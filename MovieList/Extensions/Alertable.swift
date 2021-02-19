//
//  Alertable.swift
//  MovieList
//
//  Created by Berkehan on 19.02.2021.
//

import UIKit
protocol Alertable {
    func showAlert(title: String , message: String, actions: [UIAlertAction]?)
}

//Default protocol implementation for view controllers.
extension Alertable where Self: UIViewController {
    
    
    func showAlert(title: String = "Oops..", message: String, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        present(alert, animated: true, completion: nil)
    }

  
  
    
}
