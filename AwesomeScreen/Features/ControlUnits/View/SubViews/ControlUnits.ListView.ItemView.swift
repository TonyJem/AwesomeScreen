import SwiftUI

extension ControlUnits.ListView {

    struct ItemView: View {

        var body: some View {

            HStack {
                Image(uiImage: .awesomeImage(.ecu))

                VStack {

                    BadgeLabel(.faulty)

                    Text("Engine")
                        .foregroundColor(.white)

                    Text("ID 12")
                        .foregroundColor(.gray)

                }

                Button {
                    print("🟢🟢 didTap chevron_right Button in Item")
                } label: {
                    Image(uiImage: .awesomeImage(.chevronRight))
                }
            }

        }

    }

}
