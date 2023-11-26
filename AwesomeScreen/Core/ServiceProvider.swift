import Foundation

public protocol ServiceProviderProtocol {

    var cacheService: CacheServiceProtocol { get }

    var controlUnitsService: ControlUnitServiceInterface { get }

}

public final class ServiceProvider: ServiceProviderProtocol {

    public let cacheService: CacheServiceProtocol
    public let controlUnitsService: ControlUnitServiceInterface

    public init(
        cacheService: CacheServiceProtocol,
        controlUnitsService: ControlUnitServiceInterface
    ) {
        self.cacheService = cacheService
        self.controlUnitsService = controlUnitsService
    }

}
