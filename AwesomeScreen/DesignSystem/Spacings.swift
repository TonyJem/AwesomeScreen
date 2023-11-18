import Foundation

// TODO: Add general comment here explaining the situation with spacings in general

// TODO: Review after all project is finished and remove sapcings that are ugly or not used and comment this situation
// TODO: Decide if rename spacing in accordance to names in Figma or leave it as it is. Shorter names seems are better for codebase readability... But let's try both concept and deside which is preferable...

extension ExpressibleByIntegerLiteral {

    // TODO: Add comment for each spacing
    public static var separatorHeight: Self { 1 }

    public static var spacingXXXS: Self { 2 }

    public static var spacingXXS: Self { 4 }

    public static var spacingXS: Self { 8 }

    public static var spacingS: Self { 12 }

    public static var spacingM: Self { 16 }

    public static var spacingL: Self { 24 }

    public static var spacingXL: Self { 32 }

    public static var spacingXXL: Self { 48 }

    public static var spacingXXML: Self { 56 }

    public static var spacingXXXL: Self { 64 }

}
