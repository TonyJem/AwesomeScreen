// TODO: Put all imports in all project in one same consistent order (may be ABC sorted)
import UIKit
import SwiftUI

extension ControlUnits {

    final class Presenter: ObservableObject {

        @Published var viewState: ViewState = .loading

        private let interactor: ControlUnitsInteractor

        weak var view: UIViewController?

        private var itemViewStates: [ControlUnits.ListView.ItemView.ViewState]?

        init(interactor: ControlUnitsInteractor) {
            self.interactor = interactor
        }

        // MARK: - Public

        func viewDidAppear() {
            updateContent()
            interactor.getControlUnits()
        }

        func onDidUpdateViewStates(with result: Result<[ControlUnits.ListView.ItemView.ViewState], Error>) {
            switch result {
            case .success(let viewStates):
                itemViewStates = viewStates
                updateContent()
            case .failure:
                showLoadingFailureControlUnits()
            }
        }

        func updateItems() {
            itemViewStates = nil
            updateContent()
            interactor.getControlUnits()
        }

        // MARK: - Private

        private func updateContent() {
            guard let viewStates = itemViewStates else {
                showLoadingControlUnits()
                return
            }

            if viewStates.isEmpty {
                showEmptyControlUnits()
            } else {
                showAvailableControlUnits(with: viewStates)
            }
        }

        private func showEmptyControlUnits() {
            let emptyControlUnitsScreenViewState = AwesomeEmptyView.State.emptyControlUnits.createViewState()
            viewState = .empty(emptyControlUnitsScreenViewState)
        }

        private func showAvailableControlUnits(with viewStates: [ControlUnits.ListView.ItemView.ViewState]) {
            let listViewState = ControlUnits.ListView.ViewState(
                listItemViewStates: viewStates,
                filterAction: didTapFilterAction
            )
            viewState = .unitsAvailable(listViewState)
        }

        private func showLoadingControlUnits() {
            viewState = .loading
        }

        private func showLoadingFailureControlUnits() {
            let failureControlUnitsScreenViewState = AwesomeFailureView.State.failureControlUnits.createViewState(
                with: updateItems
            )
            viewState = .loadingFailure(failureControlUnitsScreenViewState)
        }

        private func didTapFilterAction() {
            createBottomMenu()

        }

        private func createBottomMenu() {
            let alertController = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)

            let sortByIdButton = UIAlertAction(title: "Sort by ID", style: .default, handler: { (action) -> Void in
                print("🟢 didTap sort By Id Button")
            })

            let sortByNameButton = UIAlertAction(title: "Sort by Name", style: .default, handler: { (action) -> Void in
                print("🟡 didTap sort By Name Button")
            })

            let sortByStatusButton = UIAlertAction(title: "Sort by Status", style: .default, handler: { (action) -> Void in
                print("🟣 didTap sort By Status Button")
            })

            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })

            alertController.addAction(sortByIdButton)
            alertController.addAction(sortByNameButton)
            alertController.addAction(sortByStatusButton)
            alertController.addAction(cancelButton)

            view?.present(alertController, animated: true, completion: nil)
        }

    }

}
