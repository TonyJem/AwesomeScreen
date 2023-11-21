// TODO: Put all imports in all project in one same consistent order (may be ABC sorted)
import UIKit
import SwiftUI

extension ControlUnits {

    final class Presenter: ObservableObject {

        @Published var viewState: ViewState = .loading

        private let interactor: ControlUnitsInteractor

        init(interactor: ControlUnitsInteractor) {
            self.interactor = interactor
        }

        // MARK: - Public

        func viewDidAppear() {
            updateContent()
        }

        func onDidUpdateViewStates(with result: Result<[ControlUnits.ListView.ItemView.ViewState], Error>) {
            switch result {
            case .success(let viewStates):
                debugPrint("🟢🟢 In Presenter viewStates.count: \(viewStates.count)")

            case .failure(let error):
                debugPrint("🔴🔴 In Presenter failure with Error: \(error)")
            }

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
            let listItemViewStates = interactor.getControlUnitsViewStates()
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
