import Foundation

extension ControlUnits {

    enum ViewState: Equatable {

        case empty(AwesomeEmptyView.ViewState)
        case loading
        case loadingFailure(AwesomeFailureView.ViewState)
        case unitsAvailable(ControlUnits.ListView.ViewState)

        static func == (
            lhs: ControlUnits.ViewState,
            rhs: ControlUnits.ViewState
        ) -> Bool {
            switch(lhs, rhs) {

            case (.empty, .empty):
                return true

            case (.loading, .loading):
                return true

            case (.loadingFailure, .loadingFailure):
                return true

            case (.unitsAvailable(let lhsViewState), .unitsAvailable(let rhsViewState)):
                return lhsViewState == rhsViewState

            default:
                return false
            }
        }

    }

}
