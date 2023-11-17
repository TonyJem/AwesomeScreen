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
                .foregroundColor(Color(.Branded.white))

            // TODO: May be is possibel to create Color extension with Branded
            // need to check this option!
            Text(viewState.subtitle)
                .foregroundColor(Color(.Branded.white))
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
