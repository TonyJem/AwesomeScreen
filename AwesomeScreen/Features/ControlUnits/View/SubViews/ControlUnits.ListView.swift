import SwiftUI

extension ControlUnits {

    struct ListView: View {

        var body: some View {

            List {
                ItemView()

                ItemView()

                ItemView()

                ItemView()

                ItemView()
            }
            .listStyle(.plain)
            .padding(0.0)

        }

    }

}
