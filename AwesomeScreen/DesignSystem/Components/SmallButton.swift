import SwiftUI

public struct SmallButton: View {

    private let title: String
    private let image: UIImage
    private let font: UIFont
    private let titleLineHeight: CGFloat
    private let foregroundColor: Color
    private let action: (() -> Void)

    public init (
        title: String,
        image: UIImage,
        font: UIFont = .Branded.bodyMedium,
        titleLineHeight: CGFloat = 16.0,
        foregroundColor: Color = Color(.Branded.foregroundSecondary),
        action: @escaping (() -> Void)
    ) {
        self.title = title
        self.image = image
        self.font = font
        self.titleLineHeight = titleLineHeight
        self.foregroundColor = foregroundColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: .spacing2XSmall) {
                Image(uiImage: image)
                    .frame(
                        width: 16,
                        height: 16,
                        alignment: .center
                    )
                Text(title)
                    .foregroundColor(self.foregroundColor)
                    .fontWithLineHeight(
                        font: font,
                        lineHeight: titleLineHeight
                    )
            }
        }
        .padding(.vertical, .spacingXSmall)

    }

}
