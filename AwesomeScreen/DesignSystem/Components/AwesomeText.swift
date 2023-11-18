import SwiftUI

public struct AwesomeText: View {

    private let style: AwesomeTextStyle
    private let title: String

    public init(
        style: AwesomeTextStyle,
        title: String
    ) {
        self.style = style
        self.title = title
    }

    public var body: some View {
        Text(title)
            .fontWithLineHeight(
                font: style.font,
                lineHeight: style.lineHeight
            )
            .foregroundColor(style.foregroundColor)
    }

}

public enum AwesomeTextStyle {

    case title
    case subtitle

    fileprivate var font: UIFont {
        switch self {
        case .title: return .Branded.title
        case .subtitle: return .Branded.subtitle
        }
    }

    fileprivate var foregroundColor: Color {
        switch self {
        case .title: return Color(.Branded.foregroundPrimary)
        case .subtitle: return Color(.Branded.foregroundSecondary)
        }
    }

    fileprivate var lineHeight: CGFloat {
        switch self {
        case .title: return 24.0
        case .subtitle: return 16.0
        }
    }

}
