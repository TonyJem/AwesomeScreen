import Foundation

protocol ControlUnitsInteractor {

    var controlUnits: [ControlUnits.ControlUnitDomainModel] { get }

    var filteredControlUnits: [ControlUnits.ControlUnitDomainModel] { get }

    var controlUnitsSortingRule: ControlUnits.SortingRule { get }

    var isFiltering: Bool { get }

    var onDidUpdateControlUnits: ((Result<Void, Error>) -> Void)? { get set }

    func getControlUnits()

    func sortControlUnits(_ rule: ControlUnits.SortingRule)

    func filterControlUnits(_ searchText: String)

}

extension ControlUnits {

    final class Interactor: ControlUnitsInteractor {

        private struct Constants {

            static let okStatus = "ok" // String from JSON

            static let faultyStatus = "faulty" // String from JSON

        }

        var controlUnits: [ControlUnitDomainModel] = []

        var isFiltering = false

        var filteredControlUnits: [ControlUnitDomainModel] = []

        var controlUnitsSortingRule: ControlUnits.SortingRule = .byId

        var onDidUpdateControlUnits: ((Result<Void, Error>) -> Void)?

        private let controlUnitService: ControlUnitServiceInterface

        init(controlUnitService: ControlUnitServiceInterface) {
            self.controlUnitService = controlUnitService
        }

        // MARK: - Public

        func getControlUnits() {
            controlUnitService.controlUnits { [weak self] result in
                switch result {

                case .success(let units):
                    let controlUnits = units.compactMap { [weak self] unit in
                        return self?.transform(unit)
                    }
                    self?.sortAll(controlUnits)
                    self?.notifyPresenter(with: .success(()))

                case .failure(let error):
                    self?.notifyPresenter(with: .failure(error))
                }
            }
        }

        func sortControlUnits(_ rule: ControlUnits.SortingRule) {
            controlUnitsSortingRule = rule
            sortAll(controlUnits)
            notifyPresenter(with: .success(()))
        }

        func filterControlUnits(_ searchText: String) {
            isFiltering = searchText.isNotEmpty
            if isFiltering {
                filteredControlUnits = controlUnits.filter { controlUnit in
                    return controlUnit.name.lowercased().contains(searchText.lowercased())
                }
            } else {
                filteredControlUnits = []
            }
            notifyPresenter(with: .success(()))
        }

        // MARK: - Private

        private func transform(_ controlUnit: ControlUnit) -> ControlUnitDomainModel {
            return ControlUnitDomainModel(
                id: controlUnit.id,
                name: controlUnit.name,
                status: transform(controlUnit.status),
                imageUrlString: controlUnit.imageUrlString
            )
        }

        private func transform(_ status: String) -> ControlUnitDomainModel.Status {
            if status == Constants.okStatus {
                return ControlUnitDomainModel.Status.ok
            }
            if status == Constants.faultyStatus {
                return ControlUnitDomainModel.Status.faulty
            }
            return ControlUnitDomainModel.Status.notReachable
        }

        private func sortAll(_ controlUnits: [ControlUnitDomainModel]) {
            self.controlUnits = sorted(controlUnits)
            self.filteredControlUnits = sorted(filteredControlUnits)
        }

        private func sorted(_ controlUnits: [ControlUnitDomainModel]) -> [ControlUnitDomainModel] {
            switch controlUnitsSortingRule {
            case .byId:
                let sortedControlUnits = controlUnits.sorted {
                    if $0.id == $1.id && $0.name == $1.name {
                        return $0.status < $1.status
                    }
                    if $0.id == $1.id {
                        return $0.name < $1.name
                    }
                    return $0.id < $1.id
                }
                return sortedControlUnits

            case .byName:
                let sortedControlUnits = controlUnits.sorted {
                    if $0.id == $1.id && $0.name == $1.name {
                        return $0.status < $1.status
                    }
                    if $0.name == $1.name {
                        return $0.id < $1.id
                    }
                    return $0.name < $1.name
                }
                return sortedControlUnits

            case .byStatus:
                let sortedControlUnits = controlUnits.sorted {
                    if $0.id == $1.id && $0.status == $1.status {
                        return $0.name < $1.name
                    }
                    if $0.status == $1.status {
                        return $0.id < $1.id
                    }
                    return $0.status < $1.status
                }
                return sortedControlUnits
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
