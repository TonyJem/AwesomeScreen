import SwiftUI

extension ControlUnits {

    struct ContentView: View {

        let viewState = AwesomeEmptyView.State.emptyControlUnits.createViewState()

        var body: some View {
            AwesomeEmptyView(viewState: viewState)
        }

    }

}
