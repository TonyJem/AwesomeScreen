import SwiftUI

extension ControlUnits.ListView {

    struct ItemView: View {

        var body: some View {

            HStack {
                Image(uiImage: .awesomeImage(.testImage))

                VStack {

                    BadgeLabel(.faulty)

                    Text("Engine")
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)

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

extension ControlUnits.ListView.ItemView {

    // TODO: Later probably is needed to make ViewState: Identifiable
    struct ViewState {

        let id: String
        let title: String
        let image: UIImage
        let badge: String // Later need to change to custom Type describing badge style
        let action: (() -> Void)

        init(
            id: String,
            title: String,
            image: UIImage,
            badge: String,
            action: @escaping (() -> Void)
        ) {
            self.id = id
            self.title = title
            self.image = image
            self.badge = badge
            self.action = action
        }

    }

}
