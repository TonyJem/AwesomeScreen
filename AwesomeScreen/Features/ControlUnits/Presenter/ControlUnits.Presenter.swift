// TODO: Put all imports in all project in one same consistent order (may be ABC sorted)
import UIKit
import SwiftUI

extension ControlUnits {

    final class Presenter: ObservableObject {

        @Published var viewState: ViewState = .loading

        private let interactor: ControlUnitsInteractor

        weak var view: UIViewController?

        private var controlUnitViewStates: [ControlUnits.ListView.ItemView.ViewState] = []

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
            reloadControlUnits()
        }

        func onDidUpdateControlUnits(with result: Result<Void, Error>) {
            switch result {
            case .success:
                updateContent()
            case .failure:
                showFailureScreen()
            }
        }

        func reloadControlUnits() {
            showLoadingScreen()
            interactor.getControlUnits()
        }

        // MARK: - Private

        private func updateContent() {
            updateControlUnitViewStates()
            if controlUnitViewStates.isEmpty {
                showEmptyScreen()
            } else {
                showAvailableControlUnits(with: controlUnitViewStates)
            }
        }

        private func showEmptyScreen() {
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

        private func showLoadingScreen() {
            viewState = .loading
        }

        private func showFailureScreen() {
            let failureControlUnitsScreenViewState = AwesomeFailureView.State.failureControlUnits.createViewState(
                reloadAction: reloadControlUnits
            )
            viewState = .loadingFailure(failureControlUnitsScreenViewState)
        }

    }

}

// MARK: - Update ControlUnits ViewStates

extension ControlUnits.Presenter {

    private func updateControlUnitViewStates() {
        let controlUnits = interactor.controlUnits
        if controlUnits.isEmpty {
            controlUnitViewStates = []
        } else {
            controlUnitViewStates = controlUnits.map { transform(from: $0) }
        }
    }

    private func transform(from controlUnit: ControlUnit) -> ControlUnits.ListView.ItemView.ViewState {
        return ControlUnits.ListView.ItemView.ViewState(
            id: controlUnit.id,
            title: controlUnit.name,
            imageUrlString: controlUnit.imageUrlString,
            configuration: getBadgeConfiguration(for: controlUnit.status),
            action: {
                debugPrint("🟢 didTap on ControlUnit: \(controlUnit.name)")
            }
        )
    }

    private func getBadgeConfiguration(for status: String) -> BadgeLabel.Configuration? {
        guard status != "ok" else { return nil } // if status is "ok" - we do not need to create the badge
        if status == "faulty" {
            return .faulty
        } else {
            return .notReachable
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
                self?.updateContent()
            }
        )

        let sortByNameButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.nameTitle,
            style: .default,
            handler: { [weak self] _ in
                print("🟡 didTap sort By Name Button")
                self?.interactor.setControlUnitsSortingRule(.byName)
                self?.updateContent()
            }
        )

        let sortByStatusButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.statusTitle,
            style: .default,
            handler: { [weak self] _ in
                print("🔴 didTap sort By Status Button")
                self?.interactor.setControlUnitsSortingRule(.byStatus)
                self?.updateContent()
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
