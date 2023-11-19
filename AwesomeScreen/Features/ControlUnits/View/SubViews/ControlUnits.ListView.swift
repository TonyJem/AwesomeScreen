import SwiftUI

extension ControlUnits {

    struct ListView: View {

        var body: some View {

            List {
                ItemView()
                    .listRowBackground(Color.black)

                ItemView()

                ItemView()
                    .listRowBackground(Color.black)

            }
            .listStyle(.plain)
            .padding(0.0)

        }

    }

}

extension ControlUnits.ListView {

    // TODO: Perhaps is needed to make ViewState: Equatable <- we'll see when be setting SwiftUI bindings
    struct ViewState {

        let listItemViewStates: [ControlUnits.ListView.ItemView.ViewState]

        init(listItemViewStates: [ControlUnits.ListView.ItemView.ViewState]
        ) {
            self.listItemViewStates = listItemViewStates
        }

    }

}
