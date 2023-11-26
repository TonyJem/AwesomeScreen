// TODO: Put all imports in all project in one same consistent order (may be ABC sorted)
import UIKit
import SwiftUI

extension ControlUnits {

    final class Presenter: ObservableObject {

        @Published var viewState: ViewState = .loading {
            didSet {
                view?.render(viewState: viewState)
            }
        }

        let cacheService: CacheService

        private let interactor: ControlUnitsInteractor

        weak var view: ControlUnitsViewProtocol?

        private var controlUnitViewStates: [ControlUnits.ListView.ItemView.ViewState] = []

        var dataProvider: ImageService

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

            let cacheService = CacheService()

            self.interactor = interactor
            self.cacheService = cacheService
            self.dataProvider = ImageService(cacheService: cacheService)
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

        func updateCache() {
            debugPrint("🟡 updateCache main function")
            let units = interactor.controlUnits
            units.forEach { unit in
                let imageUrlString = unit.imageUrlString
                debugPrint("🟡🟡🟡 updateCache in forEach")
                dataProvider.setImageToCash(urlString: imageUrlString)
            }
        }

        func updateSearch(text: String) {
            interactor.filterControlUnits(text)
        }

        // MARK: - Private

        private func updateContent() {
            updateControlUnitViewStates()
            if controlUnitViewStates.isEmpty {
                if interactor.isFiltering {
                    showNoSearchResultsScreen()
                } else {
                    showEmptyScreen()
                }
            } else {
                showAvailableControlUnits(with: controlUnitViewStates)
            }
        }

        private func showEmptyScreen() {
            let emptyControlUnitsScreenViewState = AwesomeEmptyView.State.emptyControlUnits.createViewState()
            viewState = .empty(emptyControlUnitsScreenViewState)
        }

        private func showNoSearchResultsScreen() {
            let noSearchResultsScreenViewState = AwesomeEmptyView.State.noSearchResults.createViewState()
            viewState = .empty(noSearchResultsScreenViewState)
        }

        private func showAvailableControlUnits(with viewStates: [ControlUnits.ListView.ItemView.ViewState]) {
            let controlUnitsViewState = ControlUnits.ListView.ViewState(
                listItemViewStates: viewStates,
                sortButtonTitle: sortButtonTitle,
                sortButtonImage: .awesomeImage(.sortOutline),
                sortButtonAction: presentSortingRuleSelectionPopUp
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
        let controlUnitsToDisplay: [ControlUnits.ControlUnitDomainModel]

        if interactor.isFiltering {
            controlUnitsToDisplay = interactor.filteredControlUnits
        } else {
            controlUnitsToDisplay = interactor.controlUnits
        }

        if controlUnitsToDisplay.isEmpty {
            controlUnitViewStates = []
        } else {
            controlUnitViewStates = controlUnitsToDisplay.map { transform(from: $0) }
        }
    }

    private func transform(from domainModel: ControlUnits.ControlUnitDomainModel) -> ControlUnits.ListView.ItemView.ViewState {
        return ControlUnits.ListView.ItemView.ViewState(
            id: domainModel.id,
            title: domainModel.name,
            imageUrlString: domainModel.imageUrlString,
            configuration: getBadgeConfiguration(for: domainModel.status),
            action: {
                // Should be implemented when need to navigate into ControlUnits.Details.Screen
                debugPrint("🟢 didTap on ControlUnit: \(domainModel.name)")
            }
        )
    }

    private func getBadgeConfiguration(for status: ControlUnits.ControlUnitDomainModel.Status) -> BadgeLabel.Configuration? {
        switch status {
        case .notReachable:
            return .notReachable
        case .ok:
            return nil // if status is "ok" - we do not need to create the badge
        case .faulty:
            return .faulty
        }
    }

}

// MARK: - SortingRule SelectionPopUp

extension ControlUnits.Presenter {

    private func presentSortingRuleSelectionPopUp() {
        let alertController = UIAlertController(
            title: L10n.ControlUnits.sortingRuleSelectionPopUpTitle,
            message: nil,
            preferredStyle: .actionSheet
        )

        let sortByIdButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.idTitle,
            style: .default,
            handler: { [weak self] _ in
                self?.interactor.sortControlUnits(.byId)
            }
        )

        let sortByNameButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.nameTitle,
            style: .default,
            handler: { [weak self] _ in
                self?.interactor.sortControlUnits(.byName)
            }
        )

        let sortByStatusButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.statusTitle,
            style: .default,
            handler: { [weak self] _ in
                self?.interactor.sortControlUnits(.byStatus)
            })

        let cancelButton = UIAlertAction(
            title: L10n.ControlUnits.SortButton.cancelTitle,
            style: .cancel,
            handler: { _ in
                debugPrint("🟣🟣🟣 didTap Cancel button")
            }
        )

        sortByIdButton.setValue(true, forKey: "checked")

        let isSortedById = interactor.controlUnitsSortingRule == .byId
        let isSortedByName = interactor.controlUnitsSortingRule == .byName
        let isSortedByStatus = interactor.controlUnitsSortingRule == .byStatus

        sortByIdButton.setValue(isSortedById, forKey: "checked")
        sortByNameButton.setValue(isSortedByName, forKey: "checked")
        sortByStatusButton.setValue(isSortedByStatus, forKey: "checked")

        alertController.addAction(sortByIdButton)
        alertController.addAction(sortByNameButton)
        alertController.addAction(sortByStatusButton)
        alertController.addAction(cancelButton)

        view?.present(alertController, animated: true, completion: nil)
    }

}
