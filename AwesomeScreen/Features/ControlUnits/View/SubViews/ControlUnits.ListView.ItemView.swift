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
            HStack(spacing: .zero) {
                imageView()
                    .padding( .spacingMedium)
                    .padding( .leading, .spacing2XSmall)

                VStack(spacing: .zero) {
                    Spacer()
                    HStack(spacing: .zero) {
                        VStack(alignment: .leading, spacing: .spacing2XSmall) {
                            if let badgeConfig = viewState.configuration {
                                BadgeLabel(badgeConfig)
                                    .padding(.top, .spacing3XSmall)
                                titleView(lineLimit: 1)
                            } else {
                                titleView(lineLimit: 2)
                            }
                            subtitleView()
                        }
                        Spacer()
                        buttonView()
                            .padding(.spacingMedium)
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

                AwesomeImageView(urlString: viewState.imageUrlString)
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
        }

        private func separatorView() -> some View {
            Rectangle()
                .fill(Color(.Branded.border))
                .frame(height: .separatorHeight)
        }

    }

}

// TODO: Think if might be relevant to remove ItemView from ListView hierarchy
// just to avoid long type and redundant naming, a ?
extension ControlUnits.ListView.ItemView {

    struct ViewState: Identifiable {

        let id: String
        let title: String
        let imageUrlString: String
        let configuration: BadgeLabel.Configuration?
        let action: (() -> Void)

        // TODO: Try remove this init, looks like is not needed
        // Try to find more redundant inits
        init(
            id: String,
            title: String,
            imageUrlString: String,
            configuration: BadgeLabel.Configuration?,
            action: @escaping (() -> Void)
        ) {
            self.id = id
            self.title = title
            self.imageUrlString = imageUrlString
            self.configuration = configuration
            self.action = action
        }

    }

}
