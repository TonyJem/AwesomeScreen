import Foundation

protocol ControlUnitsInteractor {

    typealias ItemViewState = ControlUnits.ListView.ItemView.ViewState

    typealias ControlUnitsCompletion = ((Result<[ItemViewState], Error>) -> Void)

    var onDidUpdateViewStates: ControlUnitsCompletion? { get set }

    func getControlUnits()

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

        private func notifyPresenter(with result: Result<[ItemViewState], Error>) {
            guard let onDidUpdateViewStates = onDidUpdateViewStates else {
                assertionFailure("Please assign onDidUpdateViewStates to enable Presenter to get notification")
                return
            }

            DispatchQueue.main.async {
                onDidUpdateViewStates(result)
            }

        }

        // MARK: - Private

        private func onDidUpdateControlUnits(_ result: Result<[ControlUnit], Error>) {
            switch result {
            case .success(let newControlUnits):
                controlUnits = newControlUnits
                let viewStates = createControlUnitsViewStates(from: controlUnits)
                notifyPresenter(with: .success(viewStates))

            case .failure(let error):
                notifyPresenter(with: .failure(error))
            }
        }

        private func createControlUnitsViewStates(
            from units: [ControlUnit]
        ) -> [ControlUnits.ListView.ItemView.ViewState] {
            guard !units.isEmpty else { return [] }
            return units.map { createControlUnitViewState(from: $0) }
        }

        // TODO: Refactor badge Logic
        // It should not be optional
        // add "ok" state and look how to set all possible options in properway
        private func createControlUnitViewState(
            from controlUnit: ControlUnit
        ) -> ControlUnits.ListView.ItemView.ViewState {

            let badgeConfig: BadgeLabel.Configuration?

            if controlUnit.status == "ok" {
                badgeConfig = nil
            } else {
                if controlUnit.status == "faulty" {
                    badgeConfig = .faulty
                } else {
                    badgeConfig = .notReachable
                }
            }

            return ControlUnits.ListView.ItemView.ViewState(
                id: controlUnit.id,
                title: controlUnit.name,
                image: .awesomeImage(.testImage00),
                badge: badgeConfig,
                action: {
                    debugPrint("🟢 didTap on ControlUnit: \(controlUnit.name)")
                }
            )
        }

    }

}
