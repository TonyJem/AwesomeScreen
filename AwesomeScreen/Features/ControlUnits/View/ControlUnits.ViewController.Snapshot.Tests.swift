/*
import XCTest
import SnapshotTesting
@testable import AwesomeScreen

// swiftlint: disable all

final class ControlUnitsViewControllerSnapshotTests: XCTestCase {

    var interactorMock: ControlUnitsInteractorMock!
    var presenter: ControlUnits.Presenter!
    var viewController: ControlUnits.ViewController!

    override func setUp() {
        isRecording = true
    }

    func testControlUnitsEmptyView() {

        interactorMock = ControlUnitsInteractorMock()

        presenter = ControlUnits.Presenter(
            interactor: interactorMock,
            cacheService: CacheService()
        )


        let epmtyViewViewState = AwesomeEmptyView.ViewState.init(
            title: "Title",
            subtitle: "Subtitle",
            image: nil
        )

        viewController = ControlUnits.ViewController(with: presenter)

        presenter.view?.render(viewState: .empty(epmtyViewViewState))
        verifyViewController(viewController)

    }

}

// swiftlint: enable all
 */
