import SwiftUI

// TODO: Check properties and reconsder what should be private, public, let  and var and etc.
// Need to do it in whole DesignSystem file!
public struct LinkButton: View {

    private let title: String
    private let font: UIFont
    private let titleLineHeight: CGFloat
    private let foregroundColor: Color
    private let action: (() -> Void)

    public init (
        title: String,
        font: UIFont = .Branded.subtitle,
        titleLineHeight: CGFloat = 16.0,
        foregroundColor: Color = Color(.Branded.foregroundHighlight),
        action: @escaping (() -> Void)
    ) {
        self.title = title
        self.font = font
        self.titleLineHeight = titleLineHeight
        self.foregroundColor = foregroundColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(self.foregroundColor)
                .fontWithLineHeight(
                    font: font,
                    lineHeight: titleLineHeight
                )
        }
    }

}
