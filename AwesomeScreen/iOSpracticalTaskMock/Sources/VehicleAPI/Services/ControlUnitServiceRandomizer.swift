import Foundation

protocol ControlUnitServiceRandomizerInterface {
    var shouldLoadSuccessfully: Bool { get }
    var shouldLoadEmptyList: Bool { get }
}

struct ControlUnitServiceRandomizer: ControlUnitServiceRandomizerInterface {
    // MARK: - Declarations
    var shouldLoadSuccessfully: Bool { !didRollOneInTenChance() }
    var shouldLoadEmptyList: Bool { didRollOneInTenChance() }

    // MARK: - Methods
    private func didRollOneInTenChance() -> Bool { Int.random(in: 0...10) == 1 }
}
