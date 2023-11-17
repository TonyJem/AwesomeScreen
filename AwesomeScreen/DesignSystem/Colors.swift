import UIKit
import CoreGraphics
import SwiftUI

/**
 * This private namespace defines available colors as hex RGB values.
 */

private enum HexColor {

    static let white: Int = 0xffffff
    static let black: Int = 0x000000

}

/**
 * This protocol provides a predefined set of colors for the app.
 *
 *It is implemented by `UIColor`.
 */
public protocol BrandColorSupporting {
    associatedtype ColorValue

    static var white: ColorValue { get }
    static var black: ColorValue { get }

}

extension UIColor {

    internal static func color(with hexValue: Int, alpha: CGFloat = 1.0) -> UIColor {
        .init(
            red: CGFloat((hexValue & 0xff0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00ff00) >> 8) / 255.0,
            blue: CGFloat((hexValue & 0x0000ff) >> 0) / 255.0,
            alpha: alpha
        )
    }

    public enum Branded: BrandColorSupporting {

        public typealias ColorValue = UIColor

        public static var white: ColorValue { .color(with: HexColor.white) }
        public static var black: ColorValue { .color(with: HexColor.black) }

    }

}

extension CGColor {

    public enum Branded: BrandColorSupporting {

        public typealias ColorValue = CGColor

        public static var white: ColorValue { UIColor.Branded.white.cgColor }
        public static var black: ColorValue { UIColor.Branded.black.cgColor }

    }

}


