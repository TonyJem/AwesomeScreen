import Foundation
import XCTest
@testable import AwesomeScreen

// swiftlint:disable all
final class ControlUnitsInteractorTests: XCTestCase {

    // TODO: This is attemt to create first test Test
    // Looks like all work as supposed
    // Need to delete or change this test later
    func testInteractor() {

        let interactor = ControlUnits.Interactor()

        let items = interactor.getControlUnitsViewStates()

        XCTAssertEqual(items.count, 5)
    }

}

// swiftlint:enable all
