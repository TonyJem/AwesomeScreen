import SwiftUI

public struct AwesomeText: View {

    private let title: String
    private let style: AwesomeTextStyle

    public init(
        title: String,
        style: AwesomeTextStyle
    ) {
        self.title = title
        self.style = style
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
        case .title: return .Branded.titleSmall
        case .subtitle: return .Branded.bodyMedium
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
