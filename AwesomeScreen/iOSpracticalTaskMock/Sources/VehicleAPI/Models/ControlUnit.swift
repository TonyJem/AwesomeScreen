import Foundation

public struct ControlUnit {
    // MARK: - Declarations
    public let id: String
    public let name: String
    public let status: String
    public let `protocol`: String?
    public let serialNumber: String
    public let imageUrlString: String

    // MARK: - Methods
    public init(
        id: String,
        name: String,
        status: String,
        `protocol`: String?,
        serialNumber: String,
        imageUrlString: String
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.protocol = `protocol`
        self.serialNumber = serialNumber
        self.imageUrlString = imageUrlString
    }
}
