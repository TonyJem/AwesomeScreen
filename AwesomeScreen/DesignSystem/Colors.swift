import UIKit
import CoreGraphics
import SwiftUI

/**
 * This private namespace defines available colors as hex RGB values.
 */
private enum HexColor {

    static let white: Int = 0xFFFFFF
    static let black: Int = 0x000000

    static let lightBlue: Int = 0x5C9DFF
    static let lightRed: Int = 0xFF6161
}

/**
 * This protocol provides a predefined set of colors for the app.
 *
 *It is implemented by `UIColor`.
 */
public protocol BrandColorSupporting {
    associatedtype ColorValue

    static var backgroundDark: ColorValue { get }

    static var backgroundNeutral: ColorValue { get }

    static var backgroundDanger: ColorValue { get }

    static var border: ColorValue { get }

    static var foregroundOnNeutral: ColorValue { get }

    static var foregroundOnDanger: ColorValue { get }

    static var foregroundPrimary: ColorValue { get }

    static var foregroundSecondary: ColorValue { get }

    static var foregroundHighlight: ColorValue { get }

}

extension UIColor {

    /**
     * Create a color with a given RGB representation and alpha value.
     *
     * - Parameters:
     *  - hexValue: the RGB representation of color;
     *  - alpha: the alpha value of color;
     * - Returns: The `UIColor` object.
     */
    internal static func color(with hexValue: Int, alpha: CGFloat = 1.0) -> UIColor {
        .init(
            red: CGFloat((hexValue & 0xff0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00ff00) >> 8) / 255.0,
            blue: CGFloat((hexValue & 0x0000ff) >> 0) / 255.0,
            alpha: alpha
        )
    }

    public typealias ColorValue = UIColor

    public enum Branded: BrandColorSupporting {

        public static var backgroundDark: ColorValue { .color(with: HexColor.black) }

        public static var backgroundNeutral: ColorValue { .color(with: HexColor.white, alpha: 0.7) }

        public static var backgroundDanger: ColorValue { .color(with: HexColor.lightRed) }

        public static var border: ColorValue { .color(with: HexColor.white, alpha: 0.12) }

        public static var foregroundOnNeutral: ColorValue { .color(with: HexColor.black) }

        public static var foregroundOnDanger: ColorValue { .color(with: HexColor.black) }

        public static var foregroundPrimary: ColorValue { .color(with: HexColor.white) }

        public static var foregroundSecondary: ColorValue { .color(with: HexColor.white, alpha: 0.7) }

        public static var foregroundHighlight: ColorValue { .color(with: HexColor.lightBlue) }

    }

}

extension CGColor {

    public typealias ColorValue = CGColor

    public enum Branded: BrandColorSupporting {

        public static var backgroundDark: ColorValue { UIColor.Branded.backgroundDark.cgColor }

        public static var backgroundNeutral: ColorValue { UIColor.Branded.backgroundNeutral.cgColor }

        public static var backgroundDanger: ColorValue { UIColor.Branded.backgroundDanger.cgColor }

        public static var border: ColorValue { UIColor.Branded.border.cgColor }

        public static var foregroundOnNeutral: ColorValue { UIColor.Branded.foregroundOnNeutral.cgColor }

        public static var foregroundOnDanger: ColorValue { UIColor.Branded.foregroundOnDanger.cgColor }

        public static var foregroundPrimary: ColorValue { UIColor.Branded.foregroundPrimary.cgColor }

        public static var foregroundSecondary: ColorValue { UIColor.Branded.foregroundSecondary.cgColor }

        public static var foregroundHighlight: ColorValue { UIColor.Branded.foregroundHighlight.cgColor }

    }

}
