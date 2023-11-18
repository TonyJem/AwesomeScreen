import SwiftUI

extension ControlUnits {

    struct ListView: View {

        var body: some View {

            List {
                ItemView()
                    .listRowBackground(Color.black)

                ItemView()
                    .listRowBackground(Color.black)

                ItemView()
                    .listRowBackground(Color.black)

                ItemView()
                    .listRowBackground(Color.black)

                ItemView()
                    .listRowBackground(Color.black)

                BadgeLabel(title: "notReachable", config: .notReachable)
                    .listRowBackground(Color.black)

                BadgeLabel(title: "faulty", config: .faulty)
                    .listRowBackground(Color.black)
            }
            .listStyle(.plain)
            .padding(0.0)

        }

    }

}
