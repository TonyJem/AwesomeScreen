import SwiftUI

public struct BadgeLabel: View {

    private let title: String
    private let config: Configuration

    public init(
        title: String,
        config: BadgeLabel.Configuration
    ) {
        self.title = title
        self.config = config
    }

    public var body: some View {
        Text(title)
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

        fileprivate var font: UIFont {
            switch self {
            case .faulty, .notReachable: return .Branded.labelTiny
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

        fileprivate var lineHeight: CGFloat {
            switch self {
            case .faulty, .notReachable: return 12.0
            }
        }

    }

}
