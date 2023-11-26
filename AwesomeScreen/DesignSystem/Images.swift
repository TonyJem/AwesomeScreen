import UIKit
import SwiftUI

extension UIImage {

    static func awesomeImage(_ awesomeImage: AwesomeImage) -> UIImage {
        return awesomeImage.image()!
    }

    static func awesomeSymbol(_ awesomeSymbol: AwesomeSymbol) -> UIImage {
        return awesomeSymbol.image()!
    }

    static func empty() -> UIImage {
        return .awesomeImage(.noImage)
    }

}

extension Image {

    static func awesomeImage(_ awesomeImage: AwesomeImage) -> Image {
        return Image(uiImage: .awesomeImage(awesomeImage))
    }

}

enum AwesomeImage: String, CaseIterable {

    func image() -> UIImage? {
        return UIImage(named: self.rawValue)
    }

    case ecu
    case chevronRight
    case sortOutline = "sort_outline"

    case noImage

    case testImage00
    case testImage01
    case testImage02
    case testImage03
    case testImage04
}

enum AwesomeSymbol: String, CaseIterable {

    func image() -> UIImage? {
        return UIImage(systemName: self.rawValue)
    }

    case arrowClockwiseIcloud = "arrow.clockwise.icloud"
    case magnifyingGlass = "magnifyingglass"

}
