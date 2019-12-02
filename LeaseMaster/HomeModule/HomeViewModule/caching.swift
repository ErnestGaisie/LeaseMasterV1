//
//  caching.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 27/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import UIKit

class ImageCache: NSObject {
    static let sharedImageCache = ImageCache()

    // Initialize cache, specifying that your key type is AnyObject
    // and your value type is AnyObject. This is because NSCache requires
    // class types, not value types so we can't use <URL, UIImage>

    let imageCache = NSCache<AnyObject, AnyObject>()

    // Here we store the image, with the url as the key
    func add(image: UIImage, for url: URL) {
        // we cast url as AnyObject because URL is not a class type, it's a value type
        imageCache.setObject(image, forKey: url as AnyObject)
    }


    // This allows us to access the image from cache with the URL as the key
    // (e.g. cache[URL])
    func fetchImage(for url: URL) -> UIImage? {
        var image: UIImage?

        // Casting url for the same reason as before, but we also want the result
        // as an image, so we cast that as well
        image = imageCache.object(forKey: url as AnyObject) as? UIImage
        return image
    }
}
