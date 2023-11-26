import SwiftUI

extension ControlUnits.ListView {

    struct ItemView: View {

        private struct Constants {

            static let imageSize: CGSize = CGSize(width: 120, height: 60)

        }

        private let viewState: ControlUnits.ListView.ItemView.ViewState

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

                AwesomeImageView(
                    urlString: viewState.imageUrlString,
                    cacheService: viewState.cacheService
                )
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
                title: viewState.identifier,
                style: .bodyMedium
            )
        }

        private func buttonView() -> some View {
            Button {
                viewState.action()
            } label: {
                Image.awesomeImage(.chevronRight)
            }
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

        var id: UUID
        let identifier: String
        let title: String
        let imageUrlString: String
        let configuration: BadgeLabel.Configuration?
        let cacheService: CacheServiceProtocol
        let action: (() -> Void)

        init(
            id: UUID = UUID(),
            identifier: String,
            title: String,
            imageUrlString: String,
            configuration: BadgeLabel.Configuration?,
            cacheService: CacheServiceProtocol,
            action: @escaping (() -> Void)
        ) {
            self.id = id
            self.identifier = identifier
            self.title = title
            self.imageUrlString = imageUrlString
            self.configuration = configuration
            self.cacheService = cacheService
            self.action = action
        }

    }

}

extension ControlUnits.ListView.ItemView.ViewState: Equatable {

    static func == (
        lhs: ControlUnits.ListView.ItemView.ViewState,
        rhs: ControlUnits.ListView.ItemView.ViewState
    ) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.imageUrlString == rhs.imageUrlString &&
        lhs.configuration == rhs.configuration
    }

}
