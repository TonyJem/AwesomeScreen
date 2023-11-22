import SwiftUI

// TODO: Try to remove tiem separators (minor glitches I see here)
extension ControlUnits {

    struct ListView: View {

        var viewState: ControlUnits.ListView.ViewState

        init(viewState: ControlUnits.ListView.ViewState) {
            self.viewState = viewState
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                sortButton()
                .padding(.leading, .spacingMedium)

                List {
                    ForEach(viewState.controlUnitsViewStates) { viewState in
                        ItemView(viewState: viewState)
                            .listRowBackground(Color.black)
                            .listRowInsets(EdgeInsets())
                    }

                }
                .listStyle(.plain)
                .padding(0.0)
            }
        }

        private func sortButton() -> some View {
            SmallButton(
                title: viewState.sortButtonTitle,
                image: viewState.sortButtonImage,
                action: viewState.sortButtonAction
            )
        }

    }

}

extension ControlUnits.ListView {

    // TODO: Perhaps is needed to make ViewState: Equatable <- we'll see when be setting SwiftUI bindings
    struct ViewState {

        let controlUnitsViewStates: [ControlUnits.ListView.ItemView.ViewState]
        let sortButtonTitle: String
        let sortButtonImage: UIImage
        let sortButtonAction: (() -> Void)

        init(
            listItemViewStates: [ControlUnits.ListView.ItemView.ViewState],
            sortButtonTitle: String,
            sortButtonImage: UIImage,
            sortButtonAction: @escaping (() -> Void)
        ) {
            self.controlUnitsViewStates = listItemViewStates
            self.sortButtonTitle = sortButtonTitle
            self.sortButtonImage = sortButtonImage
            self.sortButtonAction = sortButtonAction
        }

    }

}
