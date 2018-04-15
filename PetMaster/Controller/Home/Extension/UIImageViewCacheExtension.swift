//
//  UIImageViewCacheExtension.swift
//  PetMaster
//
//  Created by Alex Hsieh on 2018/3/17.
//  Copyright © 2018年 Alex Hsieh. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    
    func loadImageUsingCacheWithUrlString(urlString:String) {
        
        self.image = nil
        
        
        //check cache for image first
        if let cacheImage = imageCache.object(forKey:urlString as AnyObject) as? UIImage {
            self.image = cacheImage
        }
        
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
            }
            
            DispatchQueue.main.async {
                if let downloadImage = UIImage (data:data!){
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                }
            }
            
        }).resume()
    }
}
