import SwiftUI

// TODO: Try to remove tiem separators (minor glitches I see here)
extension ControlUnits {

    struct ListView: View {

        var viewState: ControlUnits.ListView.ViewState

        init(viewState: ControlUnits.ListView.ViewState) {
            self.viewState = viewState
        }

        var body: some View {

            List {
                ForEach(viewState.listItemViewStates) { viewState in
                    ItemView(viewState: viewState)
                        .listRowBackground(Color.black)
                        .listRowInsets(EdgeInsets())
                }

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
