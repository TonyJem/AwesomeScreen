import UIKit

protocol ControlUnitsViewProtocol: UIViewController {

    func render(viewState: ControlUnits.ViewState)

}

extension ControlUnits {

    final class ViewController: UIViewController {

        // TODO: Create PresenterProtocol
        private let presenter: Presenter
        private let searchController = UISearchController(searchResultsController: nil)

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

        override func viewWillAppear(_ animated: Bool) {
            setupSearchControllerPlaceholder()
        }

        // MARK: - Private

        private func setupView() {
            setupNavigationBar()

            // TODO: Think we have to set backgound color here, instead of settgin it in Host
            let contentView = ControlUnits.ContentView(presenter: presenter)
            let host = ViewHostingController(contentView)
            host.add(to: view, useSafeArea: true)
        }

        private func setupNavigationBar() {
            setupTitle()
            setupNavigationBarButtons()
            setupSearchController()
        }

        private func setupTitle() {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(cgColor: .Branded.foregroundPrimary)
            ]
            title = L10n.ControlUnits.screenTitle
        }

    }

}

// MARK: - Setup NavigationBar Buttons

extension ControlUnits.ViewController {

    private func setupNavigationBarButtons() {
        let updateButton = updateButton()
        navigationItem.rightBarButtonItems = [
            updateButton
        ]
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

    @objc private func didTapUpdateButton() {
        presenter.reloadControlUnits()
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

    // TODO: didTapSearchButton action should be handled via Presenter
    // TODO: Put focus on search bar immediatelly, when keyboard opens
    @objc private func didTapSearchButton() {
        showSearchController()
    }

    private func showSearchController() {
        navigationItem.searchController = searchController
        setupSearchControllerText()
    }

    private func hideSearchController() {
        navigationItem.searchController = nil
    }

}

// MARK: - Setup SearchController
extension ControlUnits.ViewController {

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        setupSearchIcon()
        setupSearchPointer()
        setupSearchCancelButton()
    }

    private func setupSearchIcon() {
        let image = UIImage.awesomeSymbol(.magnifyingGlass)
            .withTintColor(UIColor.Branded.foregroundPrimary, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(image, for: .search, state: .normal)
    }

    private func setupSearchPointer() {
        searchController.searchBar.tintColor = .Branded.foregroundPrimary
    }

    private func setupSearchCancelButton() {
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Branded.foregroundPrimary]
        UIBarButtonItem
            .appearance()
            .setTitleTextAttributes(cancelButtonAttributes, for: .normal)
    }

    private func setupSearchControllerPlaceholder() {
        let placeholderText = L10n.ControlUnits.searchBarPlaceholder
        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Branded.foregroundSecondary]
        )
        searchController.searchBar.searchTextField.attributedPlaceholder = attributedPlaceholder
    }

    private func setupSearchControllerText() {
        searchController.searchBar.searchTextField.textColor = .Branded.foregroundPrimary
    }

}

// MARK: - ControlUnitsViewProtocol

extension ControlUnits.ViewController: ControlUnitsViewProtocol {

    // MARK: Public
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

    // MARK: Private
    private func showSearchButton() {
        let searchButton = searchButton()
        // enables seamless "simple solution" mentioned in suggestion: #01
        guard let items = navigationItem.rightBarButtonItems,
              items.count < 2 else {
            return
        }
        navigationItem.rightBarButtonItems?.append(searchButton)
    }

    private func hideSearchButton() {
        // Improvement suggestion: #01
        // Here is a simple solution, made just for now, which looks to be working for current layout and
        // which could be broken if more buttons in navBar will be needed to add in the future...
        // In real case it would be a suggestion for Designer to move "Search" button to the "unitsAvailable" screen's contentView
        // and avoid placing it in NavBar.
        // With such improvement it could appear together with content view, and that will improve general UX impresion to the User.
        if navigationItem.rightBarButtonItems?.count == 2 {
            navigationItem.rightBarButtonItems?.removeLast()
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

    // TODO: searchBarCancelButtonClicked action should be handled via Presenter
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchController()
    }

}
