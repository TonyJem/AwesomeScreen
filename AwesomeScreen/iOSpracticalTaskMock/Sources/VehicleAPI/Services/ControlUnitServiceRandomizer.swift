import Foundation

protocol ControlUnitServiceRandomizerInterface {
    var shouldLoadSuccessfully: Bool { get }
    var shouldLoadEmptyList: Bool { get }
}

struct ControlUnitServiceRandomizer: ControlUnitServiceRandomizerInterface {
    // MARK: - Declarations
//    var shouldLoadSuccessfully: Bool { !didRollOneInTenChance() }
//    var shouldLoadEmptyList: Bool { didRollOneInTenChance() }

    var shouldLoadSuccessfully: Bool { !didRollOneInThreeChance() }
    var shouldLoadEmptyList: Bool { didRollOneInThreeChance() }

    // MARK: - Methods
    private func didRollOneInTenChance() -> Bool { Int.random(in: 0...10) == 1 }

    private func didRollOneInThreeChance() -> Bool { Int.random(in: 0...3) == 1 }
}
