import Foundation

extension ControlUnits {

    // TODO: Later when be populating "unitsAvailable" with data need to make ViewState: Equatable
    // Otherwise refresh SwiftUI view could be broken
    enum ViewState {

        case empty(AwesomeEmptyView.ViewState)
        case loading
        case loadingFailure
        case unitsAvailable

    }

}
