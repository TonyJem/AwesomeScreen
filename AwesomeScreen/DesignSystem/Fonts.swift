import UIKit

/// This private namespace defines available font sizes in points
private enum FontSize {

    static let title: CGFloat = 18
    static let subtitle: CGFloat = 14

}

/// This protocol provides a predefined set of font faces for the app.
public protocol BrandFontSupporting {

    static var title: UIFont { get }
    static var subtitle: UIFont { get }

}


extension UIFont {

    public enum Branded: BrandFontSupporting {

        /// size: 18, type: semibold = 600.
        public static var title: UIFont = UIFont.systemFont(ofSize: FontSize.title, weight: .semibold)

        /// size: 14, type: regular = 400.
        public static var subtitle: UIFont = UIFont.systemFont(ofSize: FontSize.subtitle, weight: .regular)

    }

}
