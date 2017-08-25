import Foundation
import XCTest

class StringCompareTestHelper {

    private static let tempDir = NSTemporaryDirectory() + "codes.seanhenry.mockgenerator"
    private static let actualPath = tempDir + "/actual.txt"
    private static let expectedPath = tempDir + "/expected.txt"

    private init() {}

    static func assertEqualStrings(_ actual: String?, _ expected: String?, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(actual, expected, file: file, line: line)
        guard let actual = actual, let expected = expected, actual != expected else { return }
        try? FileManager.default.createDirectory(atPath: tempDir, withIntermediateDirectories: false, attributes: nil)
        try! actual.data(using: .utf8)!.write(to: URL(fileURLWithPath: actualPath))
        try! expected.data(using: .utf8)!.write(to: URL(fileURLWithPath: expectedPath))
        let process = Process()
        process.launchPath = "/usr/bin/opendiff"
        process.arguments = [actualPath, expectedPath]
        process.launch()
    }
}
