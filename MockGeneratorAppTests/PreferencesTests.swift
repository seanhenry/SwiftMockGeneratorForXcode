import XCTest
@testable import MockGeneratorApp

class PreferencesTests: XCTestCase {

    var preferences: Preferences!
    let testURL = URL(string: "path")!

    override func setUp() {
        super.setUp()
        preferences = Preferences()
    }

    override func tearDown() {
        preferences = nil
        super.tearDown()
    }

    // MARK: - projectPath

    func test_projectPath_shouldRememberProjectPath() {
        preferences.projectPath = testURL
        XCTAssertEqual(Preferences().projectPath, testURL)
    }

    // MARK: - jdkPath

    func test_jdkPath_shouldRememberJDKPath() {
        preferences.jdkPath = testURL
        XCTAssertEqual(Preferences().jdkPath, testURL)
    }
}
