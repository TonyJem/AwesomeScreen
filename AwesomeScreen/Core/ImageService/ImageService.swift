import UIKit
import SwiftUI

final class ImageService: ObservableObject {

    @Published var image: UIImage = UIImage()

    private let cacheService: CacheService

    init(cacheService: CacheService) {
        self.cacheService = cacheService
    }

    func getImage(by urlString: String) {
        cacheService.downloadImage(from: urlString) { image in
            self.image = image
        }
    }

}
