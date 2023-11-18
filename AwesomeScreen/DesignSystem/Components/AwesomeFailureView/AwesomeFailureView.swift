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

            Button("Try Again") {
                print("🟢 didTap Action Button in AwesomeFailureView")
            }
            .padding(.vertical, .spacingXS)

        }
        .padding(.horizontal, .spacingXL)
    }

    private func titleText() -> some View {
        Text("Unable to Load Control Unit List")
            .fontWithLineHeight(
                font: .Branded.title,
                lineHeight: 24
            )
            .foregroundColor(Color(.Branded.white))
            .multilineTextAlignment(.center)
    }

    private func subtitleText() -> some View {
        Text("Please try again later.")
            .fontWithLineHeight(
                font: .Branded.subtitle,
                lineHeight: 16
            )
            .foregroundColor(Color(.Branded.white))
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
