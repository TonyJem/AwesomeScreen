import UIKit
import SwiftUI

class DataProvider: ObservableObject {

    @Published var image: UIImage = UIImage()

    private let cacheService: CacheService

    init(cacheService: CacheService) {
        self.cacheService = cacheService
    }

    func downloadImage(urlString: String) {

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

}
