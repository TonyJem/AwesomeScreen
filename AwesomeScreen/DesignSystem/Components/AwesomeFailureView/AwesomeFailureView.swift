import SwiftUI

struct AwesomeFailureView: View {

    var viewState: AwesomeFailureView.ViewState

    init(viewState: AwesomeFailureView.ViewState) {
        self.viewState = viewState
    }

    var body: some View {
        VStack(spacing: .spacingMedium) {

            VStack(spacing: .spacing2XSmall) {
                titleText()
                subtitleText()
            }

            LinkButton(title: viewState.primaryButtonTitle) {
                viewState.primaryButtonAction()
            }
            .padding(.vertical, .spacingXSmall)

        }
        .padding(.horizontal, .spacingXL)
    }

    private func titleText() -> some View {
        AwesomeText(
            title: viewState.title,
            style: .titleSmall
        )
        .multilineTextAlignment(.center)
    }

    private func subtitleText() -> some View {
        AwesomeText(
            title: viewState.subtitle,
            style: .bodyMedium
        )
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
