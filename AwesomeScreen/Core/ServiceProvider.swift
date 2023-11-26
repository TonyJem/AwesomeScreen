import Foundation

public protocol ServiceProviderProtocol {

    var cacheService: CacheServiceProtocol { get }

}

public final class ServiceProvider: ServiceProviderProtocol {

    public let cacheService: CacheServiceProtocol

    public init(cacheService: CacheServiceProtocol) {
        self.cacheService = cacheService
    }

}
