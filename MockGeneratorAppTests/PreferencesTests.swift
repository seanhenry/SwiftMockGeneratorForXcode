import XCTest
@testable import MockGeneratorApp

class PreferencesTests: XCTestCase {

    var preferences: Preferences!
    let testURL = URL(string: "path")!
    var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        defaults = UserDefaults()
        preferences = Preferences(userDefaults: defaults)
    }

    override func tearDown() {
        preferences = nil
        defaults = nil
        super.tearDown()
    }

    // MARK: - projectPath

    func test_projectPath_shouldRememberProjectPath() {
        preferences.projectPath = testURL
        XCTAssertEqual(Preferences().projectPath, testURL)
    }
}
