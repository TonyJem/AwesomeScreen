import SwiftUI
import UIKit

final class ImageProvider: ObservableObject {

    @Published var image: UIImage = UIImage()

    private let cacheService: CacheServiceProtocol

    init(cacheService: CacheServiceProtocol) {
        self.cacheService = cacheService
    }

    func getImage(by urlString: String) {
        cacheService.downloadImage(from: urlString) { image in
            self.image = image
        }
    }

}
