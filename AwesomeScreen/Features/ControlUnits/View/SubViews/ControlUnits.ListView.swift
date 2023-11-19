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
