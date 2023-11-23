import UIKit

extension AwesomeFailureView {

    enum State {

        case failureControlUnits

    }

}

extension AwesomeFailureView.State {

    func createViewState(reloadAction: @escaping (() -> Void)) -> AwesomeFailureView.ViewState {
        var title: String
        var subtitle: String
        var primaryButtonTitle: String
        var primaryButtonAction: (() -> Void)

        switch self {
        case .failureControlUnits:
            title = L10n.AwesomeFailureView.ControlUnits.title
            subtitle = L10n.AwesomeFailureView.ControlUnits.subtitle
            primaryButtonTitle = L10n.AwesomeFailureView.ControlUnits.primaryButtonTitle
            primaryButtonAction = {
                reloadAction()
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
