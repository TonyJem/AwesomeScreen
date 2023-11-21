import UIKit

extension ControlUnits {

    final class ViewController: UIViewController {

        private let presenter: Presenter

        // MARK: - Init

        init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Lifecycle

        override func viewDidLoad() {
            super.viewDidLoad()

            setupView()
        }

        // MARK: - Private

        private func setupView() {

            // TODO: Need to decide if we want to keep it here or move ot more relevant palce
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(cgColor: .Branded.foregroundPrimary)
            ]
            // TODO: Move plain text to screen viewState and also use localized
            title = "Control Units"

            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "arrow.clockwise.icloud"),
                style: .plain,
                target: self,
                action: #selector(didTapRefreshButton)
            )

            // TODO: Think we have to set backgound color here, instead of settgin it in Host

            let contentView = ControlUnits.ContentView(presenter: presenter)
            let host = ViewHostingController(contentView)

            // TODO: Check UI and decide if we really need to accept useSafeArea,
            // May be is better jsut to center Empty view in the screen, or lift it up if useSafeArea=true
            host.add(to: view, useSafeArea: true)
        }

        @objc private func didTapRefreshButton() {
            debugPrint("🟢 addTapped")
            presenter.updateItems()
        }

    }

}
