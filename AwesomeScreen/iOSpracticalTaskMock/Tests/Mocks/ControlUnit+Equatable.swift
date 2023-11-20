import VehicleAPI

extension ControlUnit: Equatable {
    public static func == (lhs: ControlUnit, rhs: ControlUnit) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.status == rhs.status
        && lhs.protocol == rhs.protocol
        && lhs.serialNumber == rhs.serialNumber
        && lhs.imageUrlString == rhs.imageUrlString
    }
}
