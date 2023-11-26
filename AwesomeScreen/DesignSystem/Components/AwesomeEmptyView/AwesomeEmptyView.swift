import SwiftUI

struct AwesomeEmptyView: View {

    var viewState: AwesomeEmptyView.ViewState

    init(viewState: AwesomeEmptyView.ViewState) {
        self.viewState = viewState
    }

    var body: some View {
        VStack(spacing: .spacingMedium) {

            if let image = viewState.image {
                Image(uiImage: image)
            }

            VStack(spacing: .spacing2XSmall) {
                titleText()
                subtitleText()
            }

        }
        .padding(.horizontal, .spacingXLarge)
    }

    private func titleText() -> some View {
        AwesomeText(
            title: viewState.title,
            style: .titleSmall
        )
        .multilineTextAlignment(.center)
    }

    // TODO: May be is possible to create Color extension with Branded
    // need to check this option!
    // TODO: Check if I need to put limitation of number of row + truncation at the end may be...
    private func subtitleText() -> some View {
        AwesomeText(
            title: viewState.subtitle,
            style: .bodyMedium
        )
        .multilineTextAlignment(.center)
    }

}

extension AwesomeEmptyView {

    final class ViewState {

        var title: String
        var subtitle: String
        var image: UIImage?

        init(
            title: String,
            subtitle: String,
            image: UIImage?
        ) {
            self.title = title
            self.subtitle = subtitle
            self.image = image
        }

        static let intial: ViewState = ViewState(
            title: "",
            subtitle: "",
            image: nil
        )

    }

}
