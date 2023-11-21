import Foundation
import Combine

public protocol ControlUnitServiceInterface {
    func controlUnits(completion: @escaping (_ result: Result<[ControlUnit], Error>) -> Void)
    func controlUnits() async throws -> [ControlUnit]
    func controlUnits() -> Deferred<Future<[ControlUnit], Error>>

    func controlUnit(with id: String) -> ControlUnit?
    func controlUnit(with id: String) -> Deferred<Future<ControlUnit?, Never>>

    func faultCount(controlUnitId: String) -> Int
    func faultCount(controlUnitId: String) -> Deferred<Future<Int, Never>>
}

struct ControlUnitService: ControlUnitServiceInterface {
    // MARK: - Typealias
    private typealias Failure = ControlUnitServiceFailure

    // MARK: - Declarations
    static let shared: ControlUnitServiceInterface = ControlUnitService()

    // MARK: - Dependencies
    private let repository: ControlUnitsRepositoryInterface
    private let randomizer: ControlUnitServiceRandomizerInterface

    // MARK: - Methods
    init(
        repository: ControlUnitsRepositoryInterface = SampleControlUnitsRepository(),
        randomizer: ControlUnitServiceRandomizerInterface = ControlUnitServiceRandomizer()
    ) {
        self.repository = repository
        self.randomizer = randomizer
    }

    // MARK: - Methods - Control units
    func controlUnits() async throws -> [ControlUnit] {
        try await withCheckedThrowingContinuation { continuation in
            controlUnits(completion: { result in
                continuation.resume(with: result)
            })
        }
    }

    func controlUnits(completion: @escaping (_ result: Result<[ControlUnit], Error>) -> Void) {
        debugPrint("🚀 Mocked fetch item process didStart...")
        // TODO: Before finalizing project need to return to original 2 sec delay!
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let result: Result<[ControlUnit], Error>
            defer {
                debugPrint("🏁 Mocked fetch item process didFinish and we got some result.")
                completion(result)
            }

            guard randomizer.shouldLoadSuccessfully else {
                result = .failure(Failure.unableToLoadControlUnits)
                return
            }
            let loadedControlUnits = randomizer.shouldLoadEmptyList ? [] : repository.controlUnits()
            result = .success(loadedControlUnits)
        }
    }

    func controlUnits() -> Deferred<Future<[ControlUnit], Error>> {
        Deferred {
            Future<[ControlUnit], Error> { promise in
                controlUnits(completion: { result in
                    promise(result)
                })
            }
        }
    }

    // MARK: - Methods - Single control unit
    func controlUnit(with id: String) -> ControlUnit? {
        repository.controlUnits().first(where: { $0.id == id })
    }

    func controlUnit(with id: String) -> Deferred<Future<ControlUnit?, Never>> {
        Deferred {
            Future<ControlUnit?, Never> { promise in
                promise(.success(controlUnit(with: id)))
            }
        }
    }

    // MARK: - Methods - Single control unit faults
    func faultCount(controlUnitId: String) -> Int {
        guard let controlUnit = controlUnit(with: controlUnitId) else { return 0 }
        return controlUnit.status == "faulty" ? (Int(controlUnitId) ?? 1) : 0
    }

    func faultCount(controlUnitId: String) -> Deferred<Future<Int, Never>> {
        Deferred {
            Future<Int, Never> { promise in
                promise(.success(faultCount(controlUnitId: controlUnitId)))
            }
        }
    }
}
