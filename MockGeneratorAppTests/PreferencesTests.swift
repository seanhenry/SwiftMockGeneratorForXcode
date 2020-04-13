import XCTest
@testable import MockGeneratorApp

class PreferencesTests: XCTestCase {

    var preferences: Preferences!
    let testURL = URL(string: "path")!
    let testURL2 = URL(string: "path2")!
    let testData = Data()
    var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: UUID().uuidString)
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
        XCTAssertEqual(preferences.projectPath, testURL)
    }

    func test_projectPath_shouldAppendToHistory() {
        preferences.projectPath = testURL
        XCTAssertEqual(preferences.projectPathHistory, [testURL])
    }

    func test_projectPath_shouldInsertAtBeginningOfHistory() {
        preferences.projectPath = testURL
        preferences.projectPath = testURL2
        XCTAssertEqual(preferences.projectPathHistory, [testURL2, testURL])
    }

    func test_projectPath_shouldInsertAtBeginning_andRemoveDuplicates() {
        preferences.projectPath = testURL
        preferences.projectPath = testURL2
        preferences.projectPath = testURL
        preferences.projectPath = testURL2
        preferences.projectPath = testURL
        preferences.projectPath = testURL2
        preferences.projectPath = testURL
        XCTAssertEqual(preferences.projectPathHistory, [testURL, testURL2])
    }

    // MARK: - clearProjectPathHistory

    func test_clearProjectPathHistory_shouldRemoveURLs() {
        preferences.projectPath = testURL
        preferences.projectPath = testURL2
        preferences.clearProjectPathHistory()
        XCTAssert(preferences.projectPathHistory.isEmpty)
    }

    func test_clearProjectPathHistory_shouldDoNothing_whenAlreadyEmpty() {
        preferences.clearProjectPathHistory()
        XCTAssert(preferences.projectPathHistory.isEmpty)
    }

    // MARK: - automaticallyDetectProjectPath

    func test_automaticallyDetectProjectPath_shouldBeTrueByDefault() {
        XCTAssert(preferences.automaticallyDetectProjectPath)
    }

    func test_automaticallyDetectProjectPath_shouldChangeValue() {
        preferences.automaticallyDetectProjectPath = false
        XCTAssertFalse(preferences.automaticallyDetectProjectPath)
        preferences.automaticallyDetectProjectPath = true
        XCTAssert(preferences.automaticallyDetectProjectPath)
    }

    // MARK: - extensionBookmarks

    func test_extensionBookmarks_returnsNilWhenNoBookmarks() {
        XCTAssertNil(preferences.extensionBookmark(forURL: testURL))
    }

    func test_extensionBookmarks_returnsDataWhenBookmarked() {
        preferences.setExtensionBookmark(testData, forURL: testURL)
        XCTAssertEqual(preferences.extensionBookmark(forURL: testURL), testData)
        XCTAssertNil(preferences.extensionBookmark(forURL: testURL2))
    }

    // MARK: - temporaryBookmarks

    func test_temporaryBookmarks_returnsNilWhenNoBookmarks() {
        XCTAssertNil(preferences.temporaryBookmark(forURL: testURL))
    }

    func test_temporaryBookmarks_returnsDataWhenBookmarked() {
        preferences.setTemporaryBookmark(testData, forURL: testURL)
        XCTAssertEqual(preferences.temporaryBookmark(forURL: testURL), testData)
        XCTAssertNil(preferences.temporaryBookmark(forURL: testURL2))
    }
}
