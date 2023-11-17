import SwiftUI

struct AwesomeEmptyView: View {

    var body: some View {
        ZStack {
            Color.red
            Button("Hello, AwesomeEmptyView!") {

            }
            .font(.title)
            .padding()
        }
    }

}

extension AwesomeEmptyView {

    final class ViewState {

        var title: String
        var subtitle: String
        var image: UIImage

        init(
            title: String,
            subtitle: String,
            image: UIImage
        ) {
            self.title = title
            self.subtitle = subtitle
            self.image = image
        }

        static let intial: ViewState = ViewState(
            title: "",
            subtitle: "",
            image: UIImage()
        )

    }

}
