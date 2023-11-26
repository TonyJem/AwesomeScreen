@testable import AwesomeScreen

// swiftlint: disable all

final class ControlUnitsInteractorMock: ControlUnitsInteractorProtocol {

    var controlUnits: [ControlUnits.ControlUnitDomainModel] = []

    var isFiltering: Bool = false

    var filteredControlUnits: [ControlUnits.ControlUnitDomainModel] = []

    var controlUnitsSortingRule: ControlUnits.SortingRule = .byId

    var onDidUpdateControlUnits: ((Result<Void, Error>) -> Void)?

    // MARK: - getControlUnits

    var didCall_GetControlUnits: Bool = false

    func getControlUnits() {
        didCall_GetControlUnits = true
    }

    // MARK: - sortControlUnits

    var didCall_SortControlUnits: Bool = false

    func sortControlUnits(_ rule: ControlUnits.SortingRule) {
    didCall_SortControlUnits = true
    }

    // MARK: - filterControlUnits

    var didCall_FilterControlUnits: Bool = false

    func filterControlUnits(_ searchText: String) {
        didCall_FilterControlUnits = true
    }
    
}

// swiftlint: enable all
