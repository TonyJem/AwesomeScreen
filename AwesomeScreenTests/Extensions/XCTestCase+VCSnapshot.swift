import XCTest
import SnapshotTesting
import SwiftUI

extension XCTestCase {

    func verifyViewController(
        _ viewController: UIViewController,
        file: StaticString = #filePath,
        line: UInt = #line,
        testName: String = #function,
        record recording: Bool = false
    ) {

        let devices: [String: ViewImageConfig] = [
            "iPhoneSe": .iPhoneSe,
            "iPhone8": .iPhone8,
            "iPhoneX": .iPhoneX,
            "iPhoneXsMax": .iPhoneXsMax
        ]

        let results = devices.map { device in
            verifySnapshot(
                matching: viewController,
                as: .image(
                    on: device.value,
                    precision: 0.99,
                    perceptualPrecision: 0.99
                ),
                named: "\(device.key)",
                record: recording,
                file: file,
                testName: testName,
                line: line
            )
        }

        results.forEach { XCTAssertNil($0, file: file, line: line) }

    }

}
