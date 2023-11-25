import UIKit
import SwiftUI

class DataProvider: ObservableObject {

    var imageCache = NSCache<NSString, UIImage>()

    func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {

        guard let url = URL(string: urlString) else {
            debugPrint("🔴 Can't create URL for image.")
            completion(.awesomeImage(.noImage))
            return
        }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            debugPrint("🟢🟢🟢 Image used from the cache!")
            completion(cachedImage)
        } else {
            let request = URLRequest(
                url: url,
                cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,
                timeoutInterval: 10
            )

            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil,
                      data != nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let `self` = self else {
                    return
                }

                guard let image = UIImage(data: data!) else { return }
                debugPrint("🟣🟣 Image is going to be saved in cache....")
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)

                DispatchQueue.main.async {
                    debugPrint("🟣🟣🟣 Is first time downloaded image!")
                    completion(image)
                }

            }
            dataTask.resume()
        }

    }

}
