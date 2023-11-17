import SwiftUI

struct AwesomeEmptyView: View {

    var viewState: AwesomeEmptyView.ViewState

    init(viewState: AwesomeEmptyView.ViewState) {
        self.viewState = viewState
    }

    var body: some View {
        VStack {

            Image(uiImage: viewState.image)

            Text(viewState.title)
                .foregroundColor(.white)

            Text(viewState.subtitle)
                .foregroundColor(.white)
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
