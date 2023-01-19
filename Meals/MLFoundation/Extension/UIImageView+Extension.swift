//
//  UIImageView+Extension.swift
//  Meals
//
//  Created by Yongfeng on 1/15/23.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(_ urlString: String) {
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {[weak self] in
            guard let data = try? Data(contentsOf: url) else { return }

            guard let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self?.image = image
                imageCache.setObject(image, forKey: urlString as NSString)
            }
        }
    }
}
