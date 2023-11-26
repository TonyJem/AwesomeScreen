import SwiftUI

struct AwesomeImageView: View {

    @ObservedObject var imageLoader: DataProvider

    @State private var image: UIImage = .awesomeImage(.noImage)

    let urlString: String

    init(
        urlString: String,
        cacheService: CacheService
    ) {
        self.urlString = urlString
        self.imageLoader = DataProvider(cacheService: cacheService)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.downloadImage(urlString: urlString)
            }
    }

}
