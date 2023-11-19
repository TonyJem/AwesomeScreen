import Foundation

protocol ControlUnitsInteractor {

    func getControlUnitsViewStates() -> [ControlUnits.ListView.ItemView.ViewState]

}

extension ControlUnits {

    final class Interactor: ControlUnitsInteractor {

        // MARK: - Public

        func getControlUnitsViewStates() -> [ControlUnits.ListView.ItemView.ViewState] {
            print("🟢 getControlUnitsViewStates in Interactor")
            return []
        }

        // MARK: - Private

    }

}
