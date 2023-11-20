import Foundation

public struct Factory {
    // MARK: - Declarations
    public static var controlUnitService: ControlUnitServiceInterface { ControlUnitService.shared }
}
