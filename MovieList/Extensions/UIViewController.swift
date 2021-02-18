//
//  UIViewController.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit
extension UIViewController{
    func setupNavBar(right: UIBarButtonItem) {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = right
        }
    }
}

