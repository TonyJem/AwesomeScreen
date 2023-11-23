// TODO: Put all imports in all project in one same consistent order (may be ABC sorted)
import UIKit
import SwiftUI

extension ControlUnits {

    final class Presenter: ObservableObject {

        @Published var viewState: ViewState = .loading

        private let interactor: ControlUnitsInteractor

        weak var view: UIViewController?

        private var itemViewStates: [ControlUnits.ListView.ItemView.ViewState]?

        var sortButtonTitle: String {
            switch interactor.controlUnitsSortingRule {
            case .byId:
                return L10n.ControlUnits.SortButton.idTitle
            case .byName:
                return L10n.ControlUnits.SortButton.nameTitle
            case .byStatus:
                return L10n.ControlUnits.SortButton.statusTitle
            }
        }

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

        // TODO: reduce complexity:
        // we need only updateContent "doing everything" and include update items in it
        // in interactor need to decouple fetching Units from srvice and providing same to Presenter
        // ViewStates should be created in the Presenter not in Interactor
        // Interactor shoul keep models, Presenter - viestates
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
            let controlUnitsViewState = ControlUnits.ListView.ViewState(
                listItemViewStates: viewStates,
                sortButtonTitle: sortButtonTitle,
                sortButtonImage: .awesomeImage(.sortOutline),
                sortButtonAction: openSortingRuleSelectionPopUp
            )
            viewState = .unitsAvailable(controlUnitsViewState)
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

    }

}

// MARK: - SortingRule SelectionPopUp

extension ControlUnits.Presenter {

    private func openSortingRuleSelectionPopUp() {
        let alertController = UIAlertController(
            title: "Sort by",
            message: nil,
            preferredStyle: .actionSheet
        )

        let sortByIdButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.idTitle,
            style: .default,
            handler: { [weak self] _ in
                print("🟢 didTap sort By Id Button")
                self?.interactor.setControlUnitsSortingRule(.byId)
                //                    self?.updateItems()
            }
        )

        let sortByNameButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.nameTitle,
            style: .default,
            handler: { [weak self] _ in
                print("🟡 didTap sort By Name Button")
                self?.interactor.setControlUnitsSortingRule(.byName)
                //                    self?.updateItems()
            }
        )

        let sortByStatusButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.statusTitle,
            style: .default,
            handler: { [weak self] _ in
                print("🔴 didTap sort By Status Button")
                self?.interactor.setControlUnitsSortingRule(.byStatus)
                //                    self?.updateItems()
            })

        let cancelButton = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ in
                print("🟣🟣🟣 Cancel button tapped")
            })

        sortByIdButton.setValue(true, forKey: "checked")

        switch interactor.controlUnitsSortingRule {
        case .byId:
            sortByIdButton.setValue(true, forKey: "checked")
            sortByNameButton.setValue(false, forKey: "checked")
            sortByStatusButton.setValue(false, forKey: "checked")
        case .byName:
            sortByIdButton.setValue(false, forKey: "checked")
            sortByNameButton.setValue(true, forKey: "checked")
            sortByStatusButton.setValue(false, forKey: "checked")
        case .byStatus:
            sortByIdButton.setValue(false, forKey: "checked")
            sortByNameButton.setValue(false, forKey: "checked")
            sortByStatusButton.setValue(true, forKey: "checked")
        }

        alertController.addAction(sortByIdButton)
        alertController.addAction(sortByNameButton)
        alertController.addAction(sortByStatusButton)
        alertController.addAction(cancelButton)

        view?.present(alertController, animated: true, completion: nil)
    }

}
