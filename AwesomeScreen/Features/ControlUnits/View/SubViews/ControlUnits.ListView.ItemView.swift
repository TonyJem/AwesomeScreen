import SwiftUI

// TODO: Need to check UI deferneces on different iOS versions
// TODO: Native separator lines are visible <- need to remove it somehow
// TODO: Trailing part of separator does not touch trailig side of the screen <- need to solve it someHow
// TODO: Avoid clicking on whole element
// We need row do not respond to button action, only button arrea should respond on Tap
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
                VStack {
                    Spacer()
                    HStack(spacing: .spacing2XSmall) {
                        VStack(alignment: .leading, spacing: 0) {
                            if let badgeConfig = viewState.badgeConfig {
                                BadgeLabel(badgeConfig)
                                titleView(lineLimit: 1)
                            } else {
                                titleView(lineLimit: 2)
                            }
                            subtitleView()
                        }
                        Spacer()
                        buttonView()
                    }
                    Spacer()
                    separatorView()
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
                    .border(Color(.Branded.border))
                    .cornerRadius(4)
            }
        }

        private func titleView(lineLimit: Int) -> some View {
            AwesomeText(
                title: viewState.title,
                style: .labelLarge
            )
            .lineLimit(lineLimit)
        }

        private func subtitleView() -> some View {
            AwesomeText(
                title: viewState.id,
                style: .bodyMedium
            )
        }

        private func buttonView() -> some View {
            Button {
                viewState.action()
            } label: {
                Image(uiImage: .awesomeImage(.chevronRight))
            }
            .padding(.spacingMedium)
        }

        private func separatorView() -> some View {
            Rectangle()
                .fill(Color(.Branded.border))
                .frame(height: .separatorHeight)
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
