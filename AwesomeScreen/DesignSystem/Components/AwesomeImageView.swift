import SwiftUI

struct AwesomeImageView: View {

    @ObservedObject var imageProvider: ImageProvider

    @State private var image: UIImage = UIImage.empty()

    private let urlString: String

    init(
        urlString: String,
        cacheService: CacheServiceProtocol
    ) {
        self.urlString = urlString
        self.imageProvider = ImageProvider(cacheService: cacheService)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageProvider.$image) { image in
                self.image = image
            }
            .onAppear {
                imageProvider.getImage(by: urlString)
            }

    }

}
