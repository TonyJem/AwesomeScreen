import Foundation

protocol ControlUnitsIteractor {

    func getControlUnitsViewStates() -> [ControlUnits.ListView.ItemView.ViewState]

}

extension ControlUnits {

    final class Interactor: ControlUnitsIteractor {

        // MARK: - Public

        func getControlUnitsViewStates() -> [ControlUnits.ListView.ItemView.ViewState] {
            print("🟢 getControlUnitsViewStates in Interactor")
            return []
        }

        // MARK: - Private

    }

}
