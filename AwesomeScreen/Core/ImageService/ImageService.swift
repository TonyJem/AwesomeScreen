import UIKit
import SwiftUI

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

// TODO: Remove old ImageLoaderService
// TODO: Think if we need 2 download methods here or is enought to have just one
final class ImageService: ObservableObject {

    @Published var image: UIImage = UIImage()

    private let cacheService: CacheService

    init(cacheService: CacheService) {
        self.cacheService = cacheService
    }

    func getImage(by urlString: String) {

        guard let url = URL(string: urlString) else {
            debugPrint("🔴 Can't create URL from urlString for this image.")
            self.image = .awesomeImage(.noImage)
            return
        }

        if let cachedImage = cacheService.getImage(with: url) {
            debugPrint("🟢🟢🟢 Image used from the cache!")
            self.image = cachedImage
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
                self.cacheService.setImage(image: image, url: url)
                DispatchQueue.main.async {
                    debugPrint("🟣🟣🟣 Is first time downloaded image!")
                    self.image = image
                }
            }
            dataTask.resume()
        }

    }

    func setImageToCash(urlString: String) {

        guard let url = URL(string: urlString) else {
            debugPrint("🔴 Can't create URL from urlString for this image.")
            return
        }

        if cacheService.getImage(with: url) != nil {
            debugPrint("🟢🟢🟢 Image already exists!")
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
                self.cacheService.setImage(image: image, url: url)
                DispatchQueue.main.async {
                    debugPrint("🟡🟡🟡🟡🟡🟡 Download only to cache!")
                }
            }
            dataTask.resume()
        }

    }

}
