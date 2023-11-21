import Foundation

protocol ControlUnitsInteractor {

    typealias ItemViewState = ControlUnits.ListView.ItemView.ViewState

    typealias ControlUnitsCompletion = ((Result<[ItemViewState], Error>) -> Void)

    var onDidUpdateViewStates: ControlUnitsCompletion? { get set }

    func getControlUnitsViewStates() -> [ControlUnits.ListView.ItemView.ViewState]

    func getControlUnits()

}

extension ControlUnits {

    final class Interactor: ControlUnitsInteractor {

        var onDidUpdateViewStates: ControlUnitsCompletion?

        private let controlUnitService: ControlUnitServiceInterface

        private var controlUnits: [ControlUnit] = []

        init(controlUnitService: ControlUnitServiceInterface) {
            self.controlUnitService = controlUnitService
        }

        // MARK: - Public

        func getControlUnitsViewStates() -> [ControlUnits.ListView.ItemView.ViewState] {

            getControlUnits()

            return createMockViewStates()
        }

        func getControlUnits() {
            controlUnitService.controlUnits { [weak self] result in
                self?.onDidUpdateControlUnits(result)
            }
        }

        private func notifyPresenter(with result: Result<[ItemViewState], Error>) {
            guard let onDidUpdateViewStates = onDidUpdateViewStates else {
                assertionFailure("Please assign onDidUpdateViewStates to enable Presenter to get notification")
                return
            }

            DispatchQueue.main.async {
                onDidUpdateViewStates(result)
            }

        }

        // MARK: - Private

        private func onDidUpdateControlUnits(_ result: Result<[ControlUnit], Error>) {
            switch result {
            case .success(let newControlUnits):
                print("🟣🟢🟣 Success")
                print("🟢🟢🟢 items.count: \(newControlUnits.count)")

                newControlUnits.forEach { newControlUnit in
                    debugPrint("🟢 Control Unit name: \(newControlUnit.name)")
                }

                controlUnits = newControlUnits
                let viewStates = createControlUnitsViewStates(from: controlUnits)
                notifyPresenter(with: .success(viewStates))

            case .failure(let error):
                print("🔴 MOCKED FAILURE! Can't fetch items due MOCK error: \(error)")
                notifyPresenter(with: .failure(error))
            }
        }

        private func createControlUnitsViewStates(
            from units: [ControlUnit]
        ) -> [ControlUnits.ListView.ItemView.ViewState] {
            guard !units.isEmpty else { return [] }
            return units.map { createControlUnitViewState(from: $0) }
        }

        private func createControlUnitViewState(
            from controlUnit: ControlUnit
        ) -> ControlUnits.ListView.ItemView.ViewState {

            let badgeConfig: BadgeLabel.Configuration?

            if controlUnit.status == "ok" {
                badgeConfig = nil
            } else {
                if controlUnit.status == "faulty" {
                    badgeConfig = .faulty
                } else {
                    badgeConfig = .notReachable
                }
            }

            return ControlUnits.ListView.ItemView.ViewState(
                id: controlUnit.id,
                title: controlUnit.name,
                image: .awesomeImage(.testImage00),
                badge: badgeConfig,
                action: {
                    debugPrint("🟢 didTap on ControlUnit: \(controlUnit.name)")
                }
            )
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
