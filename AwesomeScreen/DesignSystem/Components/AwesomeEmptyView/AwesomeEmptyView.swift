import SwiftUI

struct AwesomeEmptyView: View {

    // TODO: Add "refreshAction"
    var viewState: AwesomeEmptyView.ViewState

    init(viewState: AwesomeEmptyView.ViewState) {
        self.viewState = viewState
    }

    var body: some View {
        VStack(spacing: .spacingM) {

            Image(uiImage: viewState.image)

            VStack(spacing: .spacingXXS) {
                titleText()
                subtitleText()
            }

        }
        .padding(.horizontal, .spacingXL)
    }

    private func titleText() -> some View {
        Text(viewState.title)
            .fontWithLineHeight(
                font: .Branded.title,
                lineHeight: 24
            )
            .foregroundColor(Color(.Branded.foregroundPrimary))
            .multilineTextAlignment(.center)
    }

    // TODO: May be is possible to create Color extension with Branded
    // need to check this option!
    // TODO: Check if I need to put limitation of number of row + truncation at the end may be...
    // TODO: Need to decide if would be relevant create reusable atoms from text blocks with predifined properties
    // or maybe custom "AwesomeText" component
    private func subtitleText() -> some View {
        Text(viewState.subtitle)
            .fontWithLineHeight(
                font: .Branded.subtitle,
                lineHeight: 16
            )
            .foregroundColor(Color(.Branded.foregroundSecondary))
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
