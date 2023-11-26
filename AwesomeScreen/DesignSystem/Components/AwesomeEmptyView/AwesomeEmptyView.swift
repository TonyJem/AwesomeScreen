import SwiftUI

public struct AwesomeEmptyView: View {

    public var viewState: AwesomeEmptyView.ViewState

    public init(viewState: AwesomeEmptyView.ViewState) {
        self.viewState = viewState
    }

    public var body: some View {
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

    // TODO: When doing snapshots:
    // Check if I need to put limitation of number of row + truncation at the end may be...
    private func subtitleText() -> some View {
        AwesomeText(
            title: viewState.subtitle,
            style: .bodyMedium
        )
        .multilineTextAlignment(.center)
    }

}

extension AwesomeEmptyView {

    public final class ViewState {

        var title: String
        var subtitle: String
        var image: UIImage?

        public init(
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
