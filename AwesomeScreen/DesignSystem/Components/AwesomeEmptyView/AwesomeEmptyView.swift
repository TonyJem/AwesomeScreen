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
                .fontWithLineHeight(
                    font: .Branded.title,
                    lineHeight: 24
                )
                .foregroundColor(Color(.Branded.white))
                .multilineTextAlignment(.center)

            // TODO: May be is possible to create Color extension with Branded
            // need to check this option!
            // TODO: Check if I need to put limitation of number of row + truncation at the end may be...
            // TODO: Move Text into private functions or decide if it relevant to create reusable atoms from it
            Text(viewState.subtitle)
                .fontWithLineHeight(
                    font: .Branded.subtitle,
                    lineHeight: 16
                )
                .foregroundColor(Color(.Branded.white))
                .multilineTextAlignment(.center)
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
