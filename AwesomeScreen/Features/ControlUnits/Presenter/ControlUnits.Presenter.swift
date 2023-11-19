// TODO: Put all imports in all project in one same consistent order (may be ABC sorted)
import UIKit
import SwiftUI

extension ControlUnits {

    final class Presenter: ObservableObject {

        @Published var viewState: ViewState = .loading

        // MARK: - Public

        func viewDidAppear() {
            updateContent()
        }

        // MARK: - Private

        // TODO: Here is temp implementation for testing reasons
        // Need to add real logic
        private func updateContent() {
//            showEmptyControlUnits()
            showAvailableControlUnits()
//            showLoadingControlUnits()
//            showLoadingFailureControlUnits()
        }

        private func showEmptyControlUnits() {
            let emptyControlUnitsScreenViewState = AwesomeEmptyView.State.emptyControlUnits.createViewState()
            viewState = .empty(emptyControlUnitsScreenViewState)
        }

        private func showAvailableControlUnits() {

            let itemViewState00 = ControlUnits.ListView.ItemView.ViewState(
                id: "ID 12",
                title: "Engine",
                image: .awesomeImage(.testImage),
                badge: "",
                action: { print("🟡 didTap on item00") }
            )

            let itemViewState01 = ControlUnits.ListView.ItemView.ViewState(
                id: "ID 01",
                title: "Engine 01",
                image: .awesomeImage(.testImage),
                badge: "",
                action: { print("🟡🟡 didTap on item01") }
            )

            let itemViewState02 = ControlUnits.ListView.ItemView.ViewState(
                id: "ID 02",
                title: "Engine 02",
                image: .awesomeImage(.testImage),
                badge: "",
                action: { print("🟡🟡🟡 didTap on item02") }
            )

            let listItemViewStates: [ControlUnits.ListView.ItemView.ViewState] = [
                itemViewState00,
                itemViewState01,
                itemViewState02
            ]

            let listViewState = ControlUnits.ListView.ViewState(listItemViewStates: listItemViewStates)

            viewState = .unitsAvailable(listViewState)
        }

        private func showLoadingControlUnits() {
            viewState = .loading
        }

        private func showLoadingFailureControlUnits() {
            let failureControlUnitsScreenViewState = AwesomeFailureView.State.failureControlUnits.createViewState()
            viewState = .loadingFailure(failureControlUnitsScreenViewState)
        }

    }

}
