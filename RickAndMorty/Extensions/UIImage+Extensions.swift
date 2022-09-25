//
//  UIImage+Extensions.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 21.09.2022.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()
extension UIImage {
    static func download(_ urlString: String, completion: @escaping (_ image: UIImage?) -> ()) {
        if let image = imageCache.object(forKey: urlString as NSString) {
            completion(image)
        } else {
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil, let safeData = data, let image = UIImage(data: safeData) else {
                    print("Error fetching the image with url: \(urlString)")
                    completion(nil)
                    return
                }
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                }
            }.resume()
        }
    }
}
