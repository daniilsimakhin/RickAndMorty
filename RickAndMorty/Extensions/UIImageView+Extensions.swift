//
//  UIImageView+Extensions.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 01.10.2022.
//

import UIKit

extension UIImageView {
    func setImageFrom(_ urlString: String) {
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image
        } else {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil, let safeData = data, let image = UIImage(data: safeData) else {
                    print("Error fetching the image with url: \(urlString)")
                    self.image = nil
                    return
                }
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }.resume()
        }
    }
}
