import Foundation
import UIKit

extension AwesomeEmptyView {

    enum State {

        case emptyControlUnits
        case noSearchResults

    }

}

extension AwesomeEmptyView.State {

    func createViewState() -> AwesomeEmptyView.ViewState {
        var title: String
        var subtitle: String
        var image: UIImage?

        switch self {
        case .emptyControlUnits:
            title = L10n.AwesomeEmptyView.ControlUnits.title
            subtitle = L10n.AwesomeEmptyView.ControlUnits.subtitle
            image = .awesomeImage(.ecu)

        case .noSearchResults:
            title = L10n.AwesomeEmptyView.NoSearchResults.title
            subtitle = L10n.AwesomeEmptyView.NoSearchResults.subtitle
            image = nil
        }

        return .init(
            title: title,
            subtitle: subtitle,
            image: image
        )
    }

}
