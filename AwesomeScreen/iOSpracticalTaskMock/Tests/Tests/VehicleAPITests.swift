import XCTest
@testable import AwesomeScreen
// @testable import VehicleAPI

/// Primitive test to ensure basic functionallity of the VehicleAPI
final class VehicleAPITests: XCTestCase {
    // MARK: - Declarations
    var sut: ControlUnitService!

    // MARK: - Declarations - Mocks
    var repositoryMock: ControlUnitsRepositoryMock!
    var randomizerMock: ControlUnitServiceRandomizerMock!

    // MARK: - Methods - Setup
    override func setUpWithError() throws {
        repositoryMock = ControlUnitsRepositoryMock()
        randomizerMock = ControlUnitServiceRandomizerMock()
        sut = ControlUnitService(repository: repositoryMock, randomizer: randomizerMock)
    }

    override func tearDownWithError() throws {
        repositoryMock = nil
        randomizerMock = nil
        sut = nil
    }

    // MARK: - Methods - Tests - Control unit list
    func test_sampleControlUnitsRepository_returns20ControlUnits() async {
        let sut = SampleControlUnitsRepository()
        let controlUnits = sut.controlUnits()
        XCTAssertEqual(controlUnits.count, 20)
    }

    func test_whenLoadingSucceeds_andListIsNotEmpty_returnsControlUnitList() async throws {
        let mockControlUnit = ControlUnit.mock()
        setupInitialState(shouldLoadSuccessfully: true, shouldLoadEmptyList: false, repositoryResult: [mockControlUnit])

        let controlUnits = try await sut.controlUnits()

        XCTAssertEqual(controlUnits, [mockControlUnit])
    }

    func test_whenLoadingSucceeds_andListIsEmpty_returnsEmptyList() async throws {
        let mockControlUnit = ControlUnit.mock()
        setupInitialState(shouldLoadSuccessfully: true, shouldLoadEmptyList: true, repositoryResult: [mockControlUnit])

        let controlUnits = try await sut.controlUnits()

        XCTAssertEqual(controlUnits, [])
    }

    func test_whenLoadingFails_throwsLoadingError() async {
        setupInitialState(shouldLoadSuccessfully: false)
        do {
            _ = try await sut.controlUnits()
            XCTFail("Unexpected case!")
        } catch {
            XCTAssertEqual(error as? ControlUnitServiceFailure, .unableToLoadControlUnits)
        }
    }

    // MARK: - Methods - Tests - Single ControlUnit
    func test_whenLoadingControlUnitById_andControlUnitExist_returnsControlUnit() {
        setupInitialState(repositoryResult: [.mock(id: "1")])
        XCTAssertEqual(sut.controlUnit(with: "1"), .mock(id: "1"))
    }

    func test_whenLoadingControlUnitById_andControlUnitIsNotFound_returnsNil() {
        setupInitialState(repositoryResult: [.mock(id: "2")])
        XCTAssertNil(sut.controlUnit(with: "1"))
    }

    // MARK: - Methods - Tests - Single ControlUnit Faults
    func test_whenLoadingControlUnitExist_andStatusIsFaulty_returnsFaultCountEqualToIdNumber() {
        setupInitialState(repositoryResult: [.mock(id: "5", status: "faulty")])
        XCTAssertEqual(sut.faultCount(controlUnitId: "5"), 5)
    }

    func test_whenLoadingControlUnitExist_andStatusIsOk_returnsZeroFaultCount() {
        setupInitialState(repositoryResult: [.mock(id: "5", status: "ok")])
        XCTAssertEqual(sut.faultCount(controlUnitId: "5"), 0)
    }

    func test_whenLoadingControlUnitIsNotFound_returnZeroFaultcount() {
        setupInitialState(repositoryResult: [.mock(id: "5", status: "faulty")])
        XCTAssertEqual(sut.faultCount(controlUnitId: "7"), 0)
    }

    // MARK: - Helpers
    private func setupInitialState(
        shouldLoadSuccessfully: Bool = true,
        shouldLoadEmptyList: Bool = false,
        repositoryResult: [ControlUnit] = []
    ) {
//        repositoryMock.controlUnits_result = repositoryResult
        repositoryMock.controlUnitsResult = repositoryResult
        randomizerMock.shouldLoadSuccessfully = shouldLoadSuccessfully
        randomizerMock.shouldLoadEmptyList = shouldLoadEmptyList
    }
}
