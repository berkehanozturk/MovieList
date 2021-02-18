//
//  UIimageView.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit

extension UIImageView {
    
//    func setRemoteImage(url: URL) {
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url) {
//
//                    DispatchQueue.main.async {
//                        if let image = UIImage(data: data){
//                            self.image = image
//
//                        }
//                    }
//
//            }
//        }
//    }
    func setRemoteImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
       
      }
}
