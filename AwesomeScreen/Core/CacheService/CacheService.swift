// TODO: Delete it when is not needed
/*
 import SwiftUI

 final class ImageLoaderService: ObservableObject {
     @Published var image: UIImage = UIImage()

     func loadImage(for urlString: String) {
         guard let url = URL(string: urlString) else { return }

         // TODO: Decide if we should handle "response"
         // TODO: Decide if we should handle "error"

         let task = URLSession.shared.dataTask(with: url) { data, _, _ in
             guard let data = data else { return }
             DispatchQueue.main.async {
                 self.image = UIImage(data: data) ?? .awesomeImage(.noImage)
             }
         }
         task.resume()
     }

 }
 */

import UIKit

final class CacheService {

    private var imageCache = NSCache<NSString, UIImage>()

    // MARK: - Public

    func downloadImage(from urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else {
            debugPrint("in CacheService: 🔴 Can't create URL for image.")
            completion(.awesomeImage(.noImage))
            return
        }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(
                url: url,
                cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,
                timeoutInterval: 10
            )
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil,
                      let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let self = self,
                      let image = UIImage(data: data)
                else {
                    completion(.awesomeImage(.noImage))
                    return
                }

                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }

            }
            dataTask.resume()
        }

    }

    // MARK: - Private:
    private func setImage(image: UIImage, url: URL) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }

    private func getImage(with url: URL) -> UIImage? {
        return imageCache.object(forKey: url.absoluteString as NSString)
    }

}
