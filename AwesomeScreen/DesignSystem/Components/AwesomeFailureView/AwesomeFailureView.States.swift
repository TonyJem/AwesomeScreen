import UIKit

extension AwesomeFailureView {

    enum State {

        case failureControlUnits

    }

}

extension AwesomeFailureView.State {

    func createViewState() -> AwesomeFailureView.ViewState {
        var title: String
        var subtitle: String
        var primaryButtonTitle: String
        var primaryButtonAction: (() -> Void)

        switch self {
        case .failureControlUnits:
            title = L10n.AwesomeEmptyView.EmptyControlUnits.title
            subtitle = L10n.AwesomeEmptyView.EmptyControlUnits.subtitle
            primaryButtonTitle = L10n.AwesomeEmptyView.EmptyControlUnits.subtitle
            primaryButtonAction = {
                // Real action will be implemented later
                // For now we just need to know if this button is tapped
                print("🟢 didTap Action Button in AwesomeFailureView")
            }
        }

        return .init(
            title: title,
            subtitle: subtitle,
            primaryButtonTitle: primaryButtonTitle,
            primaryButtonAction: primaryButtonAction
        )
    }

}
