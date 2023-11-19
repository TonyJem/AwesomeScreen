import UIKit

/// This private namespace defines available font sizes in points
private enum FontSize {

    static let titleSmall: CGFloat = 18
    static let labelLarge: CGFloat = 16
    static let bodyMedium: CGFloat = 14
    static let labelTiny: CGFloat = 10

//    labelTiny

}

/// This protocol provides a predefined set of font faces for the app.
public protocol BrandFontSupporting {

    static var titleSmall: UIFont { get }

    static var bodyMedium: UIFont { get }

    static var labelLarge: UIFont { get }

    static var labelTiny: UIFont { get }

}

extension UIFont {

    public enum Branded: BrandFontSupporting {

        /// size: 18, type: semibold = 600.
        public static var titleSmall: UIFont = UIFont.systemFont(ofSize: FontSize.titleSmall, weight: .semibold)

        /// size: 16, type: medium = 500.
        public static var labelLarge: UIFont = UIFont.systemFont(ofSize: FontSize.labelLarge, weight: .medium)

        /// size: 14, type: regular = 400.
        public static var bodyMedium: UIFont = UIFont.systemFont(ofSize: FontSize.bodyMedium, weight: .regular)

        /// size: 10, type: medium = 500.
        public static var labelTiny: UIFont = UIFont.systemFont(ofSize: FontSize.labelTiny, weight: .medium)

    }

}
