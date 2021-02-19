//
//  UIimageView.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit

extension UIImageView {
    

    func setRemoteImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil{
                DispatchQueue.main.async {
                    self.image = UIImage(named: Assets.noResult.rawValue)
                }
            }else {
                if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            }
        }.resume()
       
      }
}
