import XCTest
@testable import VehicleAPI

class ControlUnitsRepositoryMock: ControlUnitsRepositoryInterface {
    // MARK: - Declarations
    var controlUnits_result: [ControlUnit]?

    // MARK: - Methods
    func controlUnits() -> [ControlUnit] {
        guard let controlUnits_result else {
            XCTFail("control units result is not set!")
            return []
        }
        return controlUnits_result
    }
}
