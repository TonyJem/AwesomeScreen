import Foundation

protocol ControlUnitsInteractor {

    var controlUnits: [ControlUnit] { get }

    var controlUnitsSortingRule: ControlUnits.SortingRule { get }

    var onDidUpdateControlUnits: ((Result<Void, Error>) -> Void)? { get set }

    func sortControlUnits(_ rule: ControlUnits.SortingRule)

    func getControlUnits()

}

extension ControlUnits {

    final class Interactor: ControlUnitsInteractor {

        var controlUnits: [ControlUnit] = []
        var controlUnitsSortingRule: ControlUnits.SortingRule = .byId
        var onDidUpdateControlUnits: ((Result<Void, Error>) -> Void)?

        private let controlUnitService: ControlUnitServiceInterface

        init(controlUnitService: ControlUnitServiceInterface) {
            self.controlUnitService = controlUnitService
        }

        // MARK: - Public

        func sortControlUnits(_ rule: ControlUnits.SortingRule) {
            controlUnitsSortingRule = rule
            updateControlUnits(controlUnits)
        }

        func getControlUnits() {
            controlUnitService.controlUnits { [weak self] result in
                switch result {
                case .success(let controlUnits):
                    self?.updateControlUnits(controlUnits)
                    self?.notifyPresenter(with: .success(()))
                case .failure(let error):
                    self?.notifyPresenter(with: .failure(error))
                }
            }
        }

        // MARK: - Private

        private func updateControlUnits(_ controlUnits: [ControlUnit]) {
            self.controlUnits = sorted(controlUnits)
        }

        private func sorted(_ controlUnits: [ControlUnit]) -> [ControlUnit] {
            switch controlUnitsSortingRule {
            case .byId:
                let sortedControlUnits = controlUnits.sorted {
                    guard $0.id != $1.id else {
                        return $0.name < $1.name
                    }
                    return $0.id < $1.id
                }
                return sortedControlUnits

            case .byName:
                let sortedControlUnits = controlUnits.sorted {
                    guard $0.name != $1.name else {
                        return $0.id < $1.id
                    }
                    return $0.name < $1.name
                }
                return sortedControlUnits

            case .byStatus:
                debugPrint("🟡 NOT implemented")
                // TODO: Need to create and implement "byStatus" sorting logic
                return controlUnits
            }
        }

        private func notifyPresenter(with result: Result<Void, Error>) {
            guard let onDidUpdateControlUnits = onDidUpdateControlUnits else {
                assertionFailure("Please assign onDidUpdateControlUnits to enable Presenter to get notification")
                return
            }

            DispatchQueue.main.async {
                onDidUpdateControlUnits(result)
            }

        }

    }

}
