import Foundation

/// Mock repository for control units.
/// Parse strategy - JSONSerialization.
/// Reason - To keep Control Unit model untouched.
class SampleControlUnitsRepository: ControlUnitsRepositoryInterface {
    // MARK: - Enums
    private enum Failure: Error {
        case mockFileNotFound
        case unableToLoadMockDataFromFile
        case unableToParseMockDictionary
        case unableToMapControlUnit
        case unableToMapAllControlUnits
    }

    // MARK: - Constants
    private struct Constants {
        static var fileUrl: URL {
            get throws {
                guard let url = Bundle.module.url(forResource: "MockControlUnits", withExtension: "json") else {
                    throw Failure.mockFileNotFound
                }
                return url
            }
        }
    }

    // MARK: - Declarations
    private lazy var cachedControlUnits: [ControlUnit] = {
        do {
            return try mockControlUnits()
        } catch {
            print("""
            \(self) - \(#function) failed to load mock control units, error: \(error)
            Please contact us if this ever happens!
            """)
            return []
        }
    }()

    // MARK: - Methods
    func controlUnits() -> [ControlUnit] {
        return cachedControlUnits
    }

    private func mockControlUnits() throws -> [ControlUnit] {
        let fileUrl = try Constants.fileUrl
        let fileData = try fileData(from: fileUrl)
        let jsonObject = try jsonObject(from: fileData)
        let loadedControlUnits = try controlUnits(from: jsonObject)
        return loadedControlUnits
    }

    // MARK: - Helpers
    private func fileData(from url: URL) throws -> Data {
        do {
            return try Data(contentsOf: url)
        } catch {
            throw Failure.unableToLoadMockDataFromFile
        }
    }

    private func jsonObject(from data: Data) throws -> [[String: Any]] {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] ?? []
        } catch {
            throw Failure.unableToParseMockDictionary
        }
    }

    private func controlUnits(from jsonObject: [[String: Any]]) throws -> [ControlUnit] {
        do {
            return try jsonObject.map({ try controlUnit(from: $0) })
        } catch {
            throw Failure.unableToMapAllControlUnits
        }
    }

    private func controlUnit(from jsonObject: [String: Any]) throws -> ControlUnit {
        guard let id = jsonObject["id"] as? String,
              let name = jsonObject["name"] as? String,
              let status = jsonObject["status"] as? String,
              let serialNumber = jsonObject["serialNumber"] as? String,
              let imageUrlString = jsonObject["imageUrlString"] as? String else {
            throw Failure.unableToMapControlUnit
        }
        let `protocol` = jsonObject["protocol"] as? String
        return ControlUnit(
            id: id,
            name: name,
            status: status,
            protocol: `protocol`,
            serialNumber: serialNumber,
            imageUrlString: imageUrlString
        )
    }
}
