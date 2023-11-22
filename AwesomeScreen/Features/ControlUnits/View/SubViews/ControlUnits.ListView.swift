import SwiftUI

// TODO: Try to remove tiem separators (minor glitches I see here)
extension ControlUnits {

    struct ListView: View {

        // TODO: Neet to think and decide if we need this viewState,
        // if there are only viewstates inside - let use them directly!
        var viewState: ControlUnits.ListView.ViewState

        init(viewState: ControlUnits.ListView.ViewState) {
            self.viewState = viewState
        }

        var body: some View {
            VStack(alignment: .leading) {

            // TODO: Finalise this button UI and move into separate privateFunc
                // Use image from Figma assets
                Button {
                    print("🟢 didTap Status button!")
                    viewState.filterAction()
                } label: {
                    Label("Status", systemImage: "arrow.up.arrow.down")
                        .padding(EdgeInsets())
                }

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

}

extension ControlUnits.ListView {

    // TODO: Perhaps is needed to make ViewState: Equatable <- we'll see when be setting SwiftUI bindings
    struct ViewState {

        let listItemViewStates: [ControlUnits.ListView.ItemView.ViewState]

        let filterAction: (() -> Void)

        init(
            listItemViewStates: [ControlUnits.ListView.ItemView.ViewState],
            filterAction: @escaping (() -> Void)
        ) {
            self.listItemViewStates = listItemViewStates
            self.filterAction = filterAction
        }

    }

}
