import Foundation
import UIKit

extension AwesomeEmptyView {

    enum State {

        case emptyControlUnits

    }

}

extension AwesomeEmptyView.State {

    func createViewState() -> AwesomeEmptyView.ViewState {
        var title: String
        var subtitle: String
        var image: UIImage

        switch self {
        case .emptyControlUnits:
            image = .awesomeImage(.ecu)
            title = L10n.AwesomeEmptyView.EmptyControlUnits.title
            subtitle = L10n.AwesomeEmptyView.EmptyControlUnits.subtitle
        }

        return .init(
            title: title,
            subtitle: subtitle,
            image: image
        )
    }

}
