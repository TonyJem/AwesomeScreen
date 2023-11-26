import XCTest
import SnapshotTesting
@testable import AwesomeScreen

// swiftlint: disable all

final class AwesomeEmptyViewSnapshotTests: XCTestCase {

    var wrapperViewController: UIViewController!
    var emptyStateView: UIView!

    override func setUp() {
        isRecording = true

        wrapperViewController = UIViewController()
        emptyStateView = UIView().autolayout()
        wrapperViewController.view.addSubview(emptyStateView)
        wrapperViewController.view.backgroundColor = .Branded.backgroundDark

//        let parentView = wrapperViewController.view

        NSLayoutConstraint.activate([
            emptyStateView.leadingAnchor.constraint(equalTo: wrapperViewController.view.safeAreaLayoutGuide.leadingAnchor),
            emptyStateView.topAnchor.constraint(equalTo: wrapperViewController.view.safeAreaLayoutGuide.topAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: wrapperViewController.view.safeAreaLayoutGuide.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: wrapperViewController.view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }

    override func tearDownWithError() throws {
        for subview in emptyStateView.subviews {
            subview.removeFromSuperview()
        }
    }

    func testEmptyView() {

        let viewState = AwesomeEmptyView.ViewState(
            title: "Title",
            subtitle: "Subtitle",
            image: nil
        )

        let emptyView = AwesomeEmptyView(viewState: viewState)

        let host = ViewHostingController(emptyView)
        host.add(to: emptyStateView)

        verifyViewController(wrapperViewController)

    }

}

// swiftlint: enable all
