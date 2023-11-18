import SwiftUI

public struct BadgeLabel: View {

    private let config: Configuration

    public init(_ config: BadgeLabel.Configuration) {
        self.config = config
    }

    public var body: some View {
        Text(config.title)
            .fontWithLineHeight(
                font: config.font,
                lineHeight: config.lineHeight
            )
            .foregroundColor(config.foregroundColor)
            .padding(.horizontal, .spacing2XSmall)
            .padding(.vertical, .spacing3XSmall)
            .background(config.backgroundColor)
            .cornerRadius(2)
    }

}

extension BadgeLabel {

    public enum Configuration {

        case faulty
        case notReachable

        fileprivate var title: String {
            switch self {
            case .faulty: return L10n.BadgeLabel.faultyTitle
            case .notReachable: return L10n.BadgeLabel.notReachableTitle
            }
        }

        fileprivate var font: UIFont {
            switch self {
            case .faulty, .notReachable: return .Branded.labelTiny
            }
        }

        fileprivate var lineHeight: CGFloat {
            switch self {
            case .faulty, .notReachable: return 12.0
            }
        }

        fileprivate var foregroundColor: Color {
            switch self {
            case .faulty: return Color(.Branded.foregroundOnDanger)
            case .notReachable: return Color(.Branded.foregroundOnNeutral)
            }
        }

        fileprivate var backgroundColor: Color {
            switch self {
            case .faulty: return Color(.Branded.backgroundDanger)
            case .notReachable: return Color(.Branded.backgroundNeutral)
            }
        }

    }

}

extension LocalizedTranslations {

    enum BadgeLabel {

        static let notReachableTitle = "BadgeLabel.NotReachable.Title".localized

        static let faultyTitle = "BadgeLabel.Faulty.Title".localized

    }

}
