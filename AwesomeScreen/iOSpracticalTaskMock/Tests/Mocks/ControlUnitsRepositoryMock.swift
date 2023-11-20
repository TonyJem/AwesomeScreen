import XCTest
@testable import AwesomeScreen
// @testable import VehicleAPI

class ControlUnitsRepositoryMock: ControlUnitsRepositoryInterface {
    // MARK: - Declarations
//    var controlUnits_result: [ControlUnit]?
    var controlUnitsResult: [ControlUnit]?

    // MARK: - Methods
    /*
    func controlUnits() -> [ControlUnit] {
        guard let controlUnits_result else {
            XCTFail("control units result is not set!")
            return []
        }
        return controlUnits_result
    }
     */

    func controlUnits() -> [ControlUnit] {
        guard let controlUnitsResult = controlUnitsResult else {
            XCTFail("control units result is not set!")
            return []
        }
        return controlUnitsResult
    }

}
