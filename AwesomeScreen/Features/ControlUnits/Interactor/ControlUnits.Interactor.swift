import Foundation

protocol ControlUnitsInteractor {

    func getControlUnitsViewStates() -> [ControlUnits.ListView.ItemView.ViewState]

}

extension ControlUnits {

    final class Interactor: ControlUnitsInteractor {

        private let controlUnitService: ControlUnitServiceInterface

        init(controlUnitService: ControlUnitServiceInterface) {
            self.controlUnitService = controlUnitService
        }

        // MARK: - Public

        func getControlUnitsViewStates() -> [ControlUnits.ListView.ItemView.ViewState] {

            getControlUnits()

            return createMockViewStates()
        }

        // MARK: - Private

        private func getControlUnits() {
            controlUnitService.controlUnits { [weak self] result in
                self?.onDidUpdateControlUnits(result)
            }
        }

        private func onDidUpdateControlUnits(_ result: Result<[ControlUnit], Error>) {
            switch result {
            case .success(let items):
                print("🟣🟢🟣 Success")
                print("🟣🟢🟣 items.count: \(items.count)")
            case .failure(let error):
                print("🟣🟣🟣 Failure")
                print("🟣🟣🟣 error: \(error)")
            }
        }

        private func createMockViewStates() -> [ControlUnits.ListView.ItemView.ViewState] {
            let itemViewState00 = ControlUnits.ListView.ItemView.ViewState(
                id: "ID 12",
                title: "Engine",
                image: .awesomeImage(.testImage00),
                badge: .faulty,
                action: { print("🟡 didTap on item00") }
            )

            let itemViewState01 = ControlUnits.ListView.ItemView.ViewState(
                id: "ID 06",
                title: "Surround View Camera",
                image: .awesomeImage(.testImage01),
                badge: nil,
                action: { print("🟡🟡 didTap on item01") }
            )

            let itemViewState02 = ControlUnits.ListView.ItemView.ViewState(
                id: "ID 08",
                title: "Rear Short Range Radar Right",
                image: .awesomeImage(.testImage02),
                badge: nil,
                action: { print("🟡🟡🟡 didTap on item02") }
            )

            let itemViewState03 = ControlUnits.ListView.ItemView.ViewState(
                id: "ID 01",
                title: "Airbag",
                image: .awesomeImage(.testImage03),
                badge: nil,
                action: { print("🟡🟡🟡🟡 didTap on item03") }
            )

            let itemViewState04 = ControlUnits.ListView.ItemView.ViewState(
                id: "ID 43",
                title: "Front Left Light Element",
                image: .awesomeImage(.testImage04),
                badge: .notReachable,
                action: { print("🟡🟡🟡🟡🟡 didTap on item04") }
            )

            let listItemViewStates: [ControlUnits.ListView.ItemView.ViewState] = [
                itemViewState00,
                itemViewState01,
                itemViewState02,
                itemViewState03,
                itemViewState04
            ]

            return listItemViewStates
        }

    }

}
