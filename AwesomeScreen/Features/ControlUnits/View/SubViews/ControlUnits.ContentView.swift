import SwiftUI

extension ControlUnits {

    struct ContentView: View {

//        let viewState = AwesomeEmptyView.State.emptyControlUnits.createViewState()

        @ObservedObject var presenter: ControlUnits.Presenter

        var body: some View {
//            AwesomeEmptyView(viewState: viewState)
//            AwesomeLoadingView()
//            ListView()
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
            }
        }

    }

}
