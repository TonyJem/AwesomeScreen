import XCTest
@testable import AwesomeScreen
// @testable import VehicleAPI

class ControlUnitServiceRandomizerMock: ControlUnitServiceRandomizerInterface {
    // MARK: - Declarations
    var shouldLoadSuccessfully: Bool = true
    var shouldLoadEmptyList: Bool = false
}
