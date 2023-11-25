import SwiftUI

struct AwesomeImageView: View {

    var urlString: String

    @ObservedObject var imageLoader = ImageLoaderService()

    @State private var image: UIImage = .awesomeImage(.noImage)

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(for: urlString)
            }
    }

}
