@testable import VehicleAPI

extension ControlUnit {
    static func mock(
        id: String = "",
        name: String = "",
        status: String = "",
        `protocol`: String? = nil,
        serialNumber: String = "",
        imageUrlString: String = ""
    ) -> ControlUnit {
        ControlUnit(
            id: id,
            name: name,
            status: status,
            protocol: `protocol`,
            serialNumber: serialNumber,
            imageUrlString: imageUrlString
        )
    }
}
