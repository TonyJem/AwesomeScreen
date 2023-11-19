import SwiftUI

extension ControlUnits.ListView {

    struct ItemView: View {

        private struct Constants {

            static let imageSize: CGSize = CGSize(width: 120, height: 60)

        }

        let viewState: ControlUnits.ListView.ItemView.ViewState

        init(viewState: ControlUnits.ListView.ItemView.ViewState) {
            self.viewState = viewState
        }

        var body: some View {

            HStack(spacing: 0) {

                imageView()

                VStack(alignment: .leading, spacing: 0) {

                    if let badgeConfig = viewState.badgeConfig {
                        BadgeLabel(badgeConfig)
                    }

                    Text(viewState.title)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(viewState.id)
                        .foregroundColor(.gray)

                }

                Spacer()

                Button {
                    viewState.action()
                } label: {
                    Image(uiImage: .awesomeImage(.chevronRight))
                }
            }

        }

        private func imageView() -> some View {
            ZStack {
                Spacer()
                    .frame(
                        width: Constants.imageSize.width,
                        height: Constants.imageSize.height
                    )
                    .padding(.spacingMedium)

                Image(uiImage: viewState.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: Constants.imageSize.width,
                        height: Constants.imageSize.height,
                        alignment: .center
                    )
                    .border(.red)
                    .cornerRadius(4)
            }
        }

    }

}

extension ControlUnits.ListView.ItemView {

    struct ViewState: Identifiable {

        let id: String
        let title: String
        let image: UIImage
        let badgeConfig: BadgeLabel.Configuration?
        let action: (() -> Void)

        init(
            id: String,
            title: String,
            image: UIImage,
            badge: BadgeLabel.Configuration?,
            action: @escaping (() -> Void)
        ) {
            self.id = id
            self.title = title
            self.image = image
            self.badgeConfig = badge
            self.action = action
        }

    }

}
