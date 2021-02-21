//
//  UIimageView.swift
//  MovieList
//
//  Created by Berkehan on 18.02.2021.
//

import UIKit
var imageCache = NSMutableDictionary()

extension UIImageView {
    

    func setRemoteImage(from url: URL) {
        self.image = nil
        if let img = imageCache.value(forKey:"\(url)"){
            self.image = img as? UIImage
        }else{
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if err != nil{
                    DispatchQueue.main.async {
                        self.image = UIImage(named: Assets.noResult.rawValue)
                    }
                }else {
                    if let data = data {
                    let image = UIImage(data: data)
                    imageCache.setValue(image, forKey: "\(url)")
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
                }
            }.resume()
        }
        
  
       
      }
    func loadImage(url: URL,completion: @escaping (UIImage?) -> ()) {
         let utilityQueue = DispatchQueue.global(qos: .utility)
            utilityQueue.async {
    
                
                guard let data = try? Data(contentsOf: url) else { return }
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
}
