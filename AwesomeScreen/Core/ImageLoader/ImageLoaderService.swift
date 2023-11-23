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
