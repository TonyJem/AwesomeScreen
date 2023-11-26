import UIKit
import SwiftUI

extension UIImage {

    // TODO: Make sure we are using it, if not just remove
    static func awesomeImage(_ awesomeImage: AwesomeImage) -> UIImage {
        return awesomeImage.image()!
    }

    static func awesomeSymbol(_ awesomeSymbol: AwesomeSymbol) -> UIImage {
        return awesomeSymbol.image()!
    }

}

extension Image {

    // TODO: Make sure we are using it, if not just remove
    static func awesomeImage(_ awesomeImage: AwesomeImage) -> Image {
        return Image(uiImage: .awesomeImage(awesomeImage))
    }

    // TODO: Make sure we are using it, if not just remove
    // TODO: Dgi into CIImage <- what is this ?
    static func empty() -> Image {
        return Image(uiImage: UIImage(ciImage: CIImage.empty()))
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
