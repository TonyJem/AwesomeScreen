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

            LinkButton(title: viewState.primaryButtonTitle) {
                viewState.primaryButtonAction()
            }
            .padding(.vertical, .spacingXS)

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

    private func subtitleText() -> some View {
        AwesomeText(
            title: viewState.subtitle,
            style: .subtitle
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
