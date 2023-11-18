import SwiftUI

/*
 Button(action: viewState.primaryButtonAction) {
     Text(viewState.primaryButtonTitle)
         .foregroundColor(Color(.Branded.foregroundHighlight))
         .fontWithLineHeight(font: .Branded.subtitle, lineHeight: 16)
 }
 */

public struct LinkButton: View {

    let font: UIFont
    let titleLineHeight: CGFloat
    let foregroundColor: Color

    var title: String
    var action: (() -> Void)

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
