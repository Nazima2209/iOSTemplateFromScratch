//
//  UiImageView+Extension.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 20/04/22.
//

import Foundation
import UIKit

class CacheImageView: UIImageView {

    let imageCache = NSCache < NSString, AnyObject > ()
    var imageURl: String?

    func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode, completion: @escaping(_ image: UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        contentMode = imageMode
        //completion(nil)
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data) else { return }
                    self.imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                    completion(imageToCache)
                }
            }.resume()
        }
    }
}
