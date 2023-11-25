import UIKit

protocol ControlUnitsViewProtocol: UIViewController {

    func render(viewState: ControlUnits.ViewState)

}

// TODO: May be would be good to create badge showing how YY results appeared from XX possible total items
extension ControlUnits {

    final class ViewController: UIViewController {

        let searchController = UISearchController(searchResultsController: nil)

        // TODO: Create PresenterProtocol
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

            searchController.searchBar.delegate = self

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

            host.add(to: view, useSafeArea: true)
        }

        // TODO: Think if all actions shouldInformPreseneter
        @objc private func didTapUpdateButton() {
            presenter.reloadControlUnits()
        }

        @objc private func didTapSearchButton() {
            // TODO: Put focus on search bar immediatelly, when keyboard opens
            navigationItem.searchController = searchController
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

        // TODO: Need to setup text color an check Search field UI in general
        private func searchControllerSetup() {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = L10n.ControlUnits.searchBarPlaceholder
            definesPresentationContext = true

            let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField

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

        private func showSearchButton() {
            debugPrint("🟢 Show Search button here")
        }

        private func hideSearchButton() {
            debugPrint("🟡 Hide Search button here")
        }

    }

}

// MARK: - ControlUnitsViewProtocol

extension ControlUnits.ViewController: ControlUnitsViewProtocol {

    func render(viewState: ControlUnits.ViewState) {
        switch viewState {
        case
                .empty,
                .loading,
                .loadingFailure:
            hideSearchButton()

        case
                .unitsAvailable:
            showSearchButton()
        }
    }

}

// MARK: - UISearchResultsUpdating

extension ControlUnits.ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        if let text = searchController.searchBar.text {
            presenter.updateSearch(text: text)
        }

    }

}

// MARK: - UISearchBarDelegate

extension ControlUnits.ViewController: UISearchBarDelegate {

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
    }

}
