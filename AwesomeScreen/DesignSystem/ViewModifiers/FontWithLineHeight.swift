import SwiftUI

// TODO: Try to adjust calcualtion of lineSpacing, cause result is bigger then in Figma
struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) * 0.5)
    }
}

extension View {
    public func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        ModifiedContent(
            content: self,
            modifier: FontWithLineHeight(font: font, lineHeight: lineHeight)
        )
    }
}
