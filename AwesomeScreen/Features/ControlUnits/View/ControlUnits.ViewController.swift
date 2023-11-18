import UIKit

class ControlUnitsViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Private

    private func setupView() {

        // TODO: Need to dcide if we want to keep it here or move ot more relevant palce
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        // TODO: Move plain text to screen viewState and also use localized
        title = "Control Units"

        let contentView = ControlUnits.ContentView()

        let host = ViewHostingController(contentView)

        host.add(to: view)
    }

}
