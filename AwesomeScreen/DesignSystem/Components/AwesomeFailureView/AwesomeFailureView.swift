import SwiftUI

struct AwesomeFailureView: View {

    var viewState: AwesomeFailureView.ViewState

    init(viewState: AwesomeFailureView.ViewState) {
        self.viewState = viewState
    }

    var body: some View {
        VStack(spacing: .spacingM) {

            VStack(spacing: .spacingXXS) {
                titleText()
                subtitleText()
            }

            Button(action: viewState.primaryButtonAction) {
                Text(viewState.primaryButtonTitle)
                    .foregroundColor(Color(.Branded.foregroundHighlight))
                    .fontWithLineHeight(font: .Branded.title, lineHeight: 18)
            }
            .padding(.vertical, .spacingXS)

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

    private func subtitleText() -> some View {
        Text(viewState.subtitle)
            .fontWithLineHeight(
                font: .Branded.subtitle,
                lineHeight: 16
            )
            .foregroundColor(Color(.Branded.foregroundPrimary))
            .multilineTextAlignment(.center)
    }

}

extension AwesomeFailureView {

    final class ViewState {

        var title: String
        var subtitle: String
        var primaryButtonTitle: String
        var primaryButtonAction: (() -> Void)

        init(
            title: String,
            subtitle: String,
            primaryButtonTitle: String,
            primaryButtonAction: @escaping (() -> Void)
        ) {
            self.title = title
            self.subtitle = subtitle
            self.primaryButtonTitle = primaryButtonTitle
            self.primaryButtonAction = primaryButtonAction
        }

        static let intial: ViewState = ViewState(
            title: "",
            subtitle: "",
            primaryButtonTitle: "") {
                // Intentionally unimplemented.
            }

    }

}
