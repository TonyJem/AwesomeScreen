import Foundation

protocol ControlUnitsInteractor {

    typealias ItemViewState = ControlUnits.ListView.ItemView.ViewState

    typealias ControlUnitsCompletion = ((Result<[ItemViewState], Error>) -> Void)

    var onDidUpdateViewStates: ControlUnitsCompletion? { get set }

    func getControlUnits()

    func sortControlUnits(by sort: ControlUnits.SortOption)

}

extension ControlUnits {

    final class Interactor: ControlUnitsInteractor {

        var onDidUpdateViewStates: ControlUnitsCompletion?

        private let controlUnitService: ControlUnitServiceInterface

        private var controlUnits: [ControlUnit] = []

        init(controlUnitService: ControlUnitServiceInterface) {
            self.controlUnitService = controlUnitService
        }

        // MARK: - Public

        func getControlUnits() {
            controlUnitService.controlUnits { [weak self] result in
                self?.onDidUpdateControlUnits(result)
            }
        }

        func sortControlUnits(by sort: ControlUnits.SortOption) {
            switch sort {
            case .byId:
                sortById()
            case .byName:
                sortByName()
            case .byStatus:
                debugPrint("🔴 Not implemented yet")
            }
        }

        // MARK: - Private

        private func sortById() {
            guard !controlUnits.isEmpty else { return }

            controlUnits = controlUnits.sorted {
                guard $0.id != $1.id else {
                    return $0.name < $1.name
                }
                return $0.id < $1.id
            }

            let viewStates = createViewStates(from: controlUnits)
            notifyPresenter(with: .success(viewStates))
        }

        private func sortByName() {
            guard !controlUnits.isEmpty else { return }

            controlUnits = controlUnits.sorted {
                guard $0.name != $1.name else {
                    return $0.id < $1.id
                }
                return $0.name < $1.name
            }

            let viewStates = createViewStates(from: controlUnits)
            notifyPresenter(with: .success(viewStates))
        }

        private func onDidUpdateControlUnits(_ result: Result<[ControlUnit], Error>) {
            switch result {
            case .success(let newControlUnits):
                controlUnits = newControlUnits
                let viewStates = createViewStates(from: controlUnits)
                notifyPresenter(with: .success(viewStates))

            case .failure(let error):
                notifyPresenter(with: .failure(error))
            }
        }

        private func notifyPresenter(with result: Result<[ItemViewState], Error>) {
            guard let onDidUpdateViewStates = onDidUpdateViewStates else {
                assertionFailure("Please assign onDidUpdateViewStates to enable Presenter to get notification")
                return
            }

            DispatchQueue.main.async {
                onDidUpdateViewStates(result)
            }

        }

        private func createViewStates(
            from units: [ControlUnit]
        ) -> [ControlUnits.ListView.ItemView.ViewState] {

            guard !units.isEmpty else { return [] }
            return units.map { transform(from: $0) }
        }

        private func transform(from controlUnit: ControlUnit) -> ControlUnits.ListView.ItemView.ViewState {
            return ControlUnits.ListView.ItemView.ViewState(
                id: controlUnit.id,
                title: controlUnit.name,
                imageUrlString: controlUnit.imageUrlString,
                configuration: badgeConfiguration(for: controlUnit.status),
                action: {
                    debugPrint("🟢 didTap on ControlUnit: \(controlUnit.name)")
                }
            )
        }

        private func badgeConfiguration(for status: String) -> BadgeLabel.Configuration? {
            guard status != "ok" else { return nil } // if status is "ok" - we do not need to create the badge
            if status == "faulty" {
                return .faulty
            } else {
                return .notReachable
            }
        }

    }

}
