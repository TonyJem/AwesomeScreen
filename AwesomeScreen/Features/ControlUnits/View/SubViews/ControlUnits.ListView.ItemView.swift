import SwiftUI

extension ControlUnits.ListView {

    struct ItemView: View {

        let viewState: ControlUnits.ListView.ItemView.ViewState

        init(viewState: ControlUnits.ListView.ItemView.ViewState) {
            self.viewState = viewState
        }

        var body: some View {

            HStack {
                Image(uiImage: viewState.image)

                VStack {

                    BadgeLabel(.faulty)

                    Text(viewState.title)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(viewState.id)
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

    struct ViewState: Identifiable {

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
