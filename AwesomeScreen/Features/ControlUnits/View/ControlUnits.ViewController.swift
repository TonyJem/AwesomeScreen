import UIKit

class ControlUnitsViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Private

    private func setupView() {

        title = "Control Units"

        let contentView = ControlUnits.ContentView()

        let host = ViewHostingController(contentView)

        host.add(to: view)
    }

}
