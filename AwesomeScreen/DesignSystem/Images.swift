import UIKit
import SwiftUI

// TODO: Try to move Assets into DesignSystem

extension UIImage {

    // TODO: Make sure we are using it, if not just remove
    static func awesomeImage(_ awesomeImage: AwesomeImage) -> UIImage {
        return awesomeImage.image()!
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

    case ecu = "ecu"
    case chevronRight = "chevronRight"
    case testImage = "testImage"

}
