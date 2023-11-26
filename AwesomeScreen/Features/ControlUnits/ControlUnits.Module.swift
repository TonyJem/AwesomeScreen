import UIKit

protocol ControlUnitsModuleProtocol {

    func getView() -> UIViewController

}

extension ControlUnits {

    final class Module: ControlUnitsModuleProtocol {

        private let serviceProvider: ServiceProviderProtocol

        init(
            serviceProvider: ServiceProviderProtocol
        ) {
            self.serviceProvider = serviceProvider
        }

        // MARK: - Public

        func getView() -> UIViewController {
            let presenter = getPresenter()
            let viewController = ControlUnits.ViewController(with: presenter)
            presenter.view = viewController
            return viewController
        }

        // MARK: - Private

        private func getPresenter() -> ControlUnits.Presenter {
            let interactor = ControlUnits.Interactor(
                controlUnitService: serviceProvider.controlUnitsService,
                cacheService: serviceProvider.cacheService
            )
            let presenter = ControlUnits.Presenter(interactor: interactor)
            interactor.onDidUpdateControlUnits = { [weak presenter] result in
                presenter?.onDidUpdateControlUnits(with: result)
            }
            return presenter
        }

    }

}
