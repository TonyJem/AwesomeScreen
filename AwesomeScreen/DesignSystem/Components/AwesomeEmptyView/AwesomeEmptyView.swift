import SwiftUI

struct AwesomeEmptyView: View {

    // TODO: Add "refreshAction"
    var viewState: AwesomeEmptyView.ViewState

    init(viewState: AwesomeEmptyView.ViewState) {
        self.viewState = viewState
    }

    var body: some View {
        VStack(spacing: .spacingMedium) {

            Image(uiImage: viewState.image)

            VStack(spacing: .spacing2XSmall) {
                titleText()
                subtitleText()
            }

        }
        .padding(.horizontal, .spacingXL)
    }

    private func titleText() -> some View {
        AwesomeText(
            title: viewState.title,
            style: .title
        )
        .multilineTextAlignment(.center)
    }

    // TODO: May be is possible to create Color extension with Branded
    // need to check this option!
    // TODO: Check if I need to put limitation of number of row + truncation at the end may be...
    private func subtitleText() -> some View {
        AwesomeText(
            title: viewState.subtitle,
            style: .subtitle
        )
        .multilineTextAlignment(.center)
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
