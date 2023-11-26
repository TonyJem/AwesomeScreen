import UIKit

protocol ControlUnitsModuleProtocol {

    func getView() -> UIViewController

}

extension ControlUnits {

    final class Module: ControlUnitsModuleProtocol {

        private let serviceProtocol: ServiceProviderProtocol

        init(
            serviceProtocol: ServiceProviderProtocol
        ) {
            self.serviceProtocol = serviceProtocol
        }

        func getView() -> UIViewController {

            UIViewController()
        }

        // MARK: - Private

        private func getPresenter() {

        }

    }

}
