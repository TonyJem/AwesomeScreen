import UIKit

extension ControlUnits {

    // TODO: Create ControlUnitsView protocol
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

            title = L10n.ControlUnits.screenTitle

            searchControllerSetup()

            // TODO: Show searchButton only on main screen
            let updateButton = updateButton()
            let searchButton = searchButton()
            navigationItem.rightBarButtonItems = [
                updateButton,
                searchButton
            ]

            let image = UIImage.awesomeSymbol(.magnifyingGlass).withTintColor(
                .white,
                renderingMode: .alwaysOriginal
            )
                UISearchBar.appearance().setImage(image, for: .search, state: .normal)

            // TODO: Think we have to set backgound color here, instead of settgin it in Host

            let contentView = ControlUnits.ContentView(presenter: presenter)
            let host = ViewHostingController(contentView)

            // TODO: Check UI and decide if we really need to accept useSafeArea,
            // May be is better jsut to center Empty view in the screen, or lift it up if useSafeArea=true
            host.add(to: view, useSafeArea: true)
        }

        @objc private func didTapUpdateButton() {
            presenter.reloadControlUnits()
        }

        @objc private func didTapSearchButton() {
            debugPrint("🟢 didTapSearchButton")
        }

        private func updateButton() -> UIBarButtonItem {
            let updateButton = UIBarButtonItem(
                image: .awesomeSymbol(.arrowClockwiseIcloud),
                style: .plain,
                target: self,
                action: #selector(didTapUpdateButton)
            )
            updateButton.tintColor = .Branded.foregroundHighlight
            return updateButton
        }

        private func searchButton() -> UIBarButtonItem {
            let searchButton = UIBarButtonItem(
                image: .awesomeSymbol(.magnifyingGlass),
                style: .plain,
                target: self,
                action: #selector(didTapSearchButton)
            )
            searchButton.tintColor = .Branded.foregroundPrimary
            return searchButton
        }

        private func searchControllerSetup() {
            let search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self
            search.obscuresBackgroundDuringPresentation = false

            search.searchBar.placeholder = L10n.ControlUnits.searchBarPlaceholder
            navigationItem.searchController = search

            let textFieldInsideSearchBar = search.searchBar.value(forKey: "searchField") as? UITextField

            textFieldInsideSearchBar?.textColor = .Branded.foregroundPrimary

            // TODO: Redo force unwrap
            let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
            textFieldInsideSearchBarLabel?.textColor = .Branded.foregroundSecondary

            // TODO: Try Add Branded color
            let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UIBarButtonItem
                .appearance()
                .setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        }

    }

}

// MARK: - UISearchResultsUpdating

extension ControlUnits.ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

    }

}
