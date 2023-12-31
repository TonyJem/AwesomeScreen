import UIKit

public protocol CacheServiceProtocol {

    func downloadImage(from urlString: String, completion: @escaping (UIImage) -> Void)

}

final public class CacheService: CacheServiceProtocol {

    private struct Constants {

        static let timeoutInterval = 10.0 // Reduces request timeout interval value from default 60.0

    }

    private var imageCache = NSCache<NSString, UIImage>()

    // MARK: - Public

    public func downloadImage(from urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else {
            debugPrint("in CacheService: 🔴 Can't create URL for image.")
            completion(UIImage.empty())
            return
        }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(
                url: url,
                cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,
                timeoutInterval: Constants.timeoutInterval
            )
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil,
                      let data = data,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let self = self,
                      let image = UIImage(data: data)
                else {
                    completion(UIImage.empty())
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
