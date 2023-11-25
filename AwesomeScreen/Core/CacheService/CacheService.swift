import UIKit

class CacheService {

    private var imageCache = NSCache<NSString, UIImage>()

    func setImage(image: UIImage, url: URL) {
        debugPrint("🟣🟣 Image is about to be saved in cache....")
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }

    func getImage(with url: URL) -> UIImage? {
        return imageCache.object(forKey: url.absoluteString as NSString)
    }

}
