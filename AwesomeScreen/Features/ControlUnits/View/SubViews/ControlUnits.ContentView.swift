import SwiftUI

extension ControlUnits {

    struct ContentView: View {

        @ObservedObject var presenter: ControlUnits.Presenter

        var body: some View {
            contentView()
                .onAppear(perform: presenter.viewDidAppear)
        }

        @ViewBuilder
        private func contentView() -> some View {
            switch presenter.viewState {
            case .empty(let viewState):
                AwesomeEmptyView(viewState: viewState)
            case .loading:
                AwesomeLoadingView()
            case .unitsAvailable:
                ListView()
            case .loadingFailure(let viewState):
                AwesomeFailureView(viewState: viewState)
            }
        }

    }

}
