import Foundation

/**
 * This extension adds predifined values of spacing.
 *
 * The constants defined here should be used for spacing,
 * inset, padding and margin definitions as much as possible.
 * Extending `ExpressibleByIntegerLiteral` adds these constants
 * to all types that can be initialized with an integer, such as `Int`, `Double` or `CGFLoat`.
 */
extension ExpressibleByIntegerLiteral {

    /// Represents empty space with size of 1 pt
    public static var separatorHeight: Self { 1 }

    /// Represents empty space with size of 2 pt
    public static var spacing3XSmall: Self { 2 }

    /// Represents empty space with size of 4 pt
    public static var spacing2XSmall: Self { 4 }

    /// Represents empty space with size of 8 pt
    public static var spacingXSmall: Self { 8 }

    /// Represents empty space with size of 16 pt
    public static var spacingMedium: Self { 16 }

    /// Represents empty space with size of 32 pt
    public static var spacingXLarge: Self { 32 }

}
