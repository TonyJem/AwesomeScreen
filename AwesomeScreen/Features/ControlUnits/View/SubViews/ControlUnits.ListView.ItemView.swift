import SwiftUI

extension ControlUnits.ListView {

    struct ItemView: View {

        private struct Constants {

            static let imageSize: CGSize = CGSize(width: 120, height: 60)

        }

        private let viewState: ControlUnits.ListView.ItemView.ViewState
        private let cacheService: CacheServiceProtocol

        init(
            viewState: ControlUnits.ListView.ItemView.ViewState,
            cacheService: CacheServiceProtocol
        ) {
            self.viewState = viewState
            self.cacheService = cacheService
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
                    cacheService: cacheService
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

        // TODO: Change id with real uniq ID jsut in case use UUID() when creating thi viewstate
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
