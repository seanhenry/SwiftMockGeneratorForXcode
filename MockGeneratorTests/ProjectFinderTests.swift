import XCTest
@testable import MockGenerator

class ProjectFinderTests: XCTestCase {

    var finder: ProjectFinder!
    var preferences: Preferences!
    var mockProjectFinder: MockProjectFinder!
    let projectPath = "/path/to/project"
    let projectFolder = "/path/to/project/MyProject.xcodeproj"

    override func setUp() {
        super.setUp()
        preferences = Preferences(userDefaults: UserDefaults(suiteName: UUID().uuidString)!)
        mockProjectFinder = MockProjectFinder()
        finder = ProjectFinder(projectFinder: mockProjectFinder, preferences: preferences)
    }

    override func tearDown() {
        finder = nil
        preferences = nil
        mockProjectFinder = nil
        super.tearDown()
    }

    // MARK: - getProjectPath

    func test_getProjectPath_shouldReturnErrorMessage_whenManualPathHasNotBeenSpecified() {
        preferences.automaticallyDetectProjectPath = false
        preferences.projectPath = nil
        assertEqualError("Set the project path in the Mock Generator companion app.")
    }

    func test_getProjectPath_shouldReturnManualProjectPath() {
        preferences.automaticallyDetectProjectPath = false
        preferences.projectPath = URL(fileURLWithPath: projectPath)
        assertEqualProjectPath(projectPath)
    }

    func test_getProjectPath_shouldReturnErrorMessage_whenAutomaticPathCannotBeFound() {
        preferences.automaticallyDetectProjectPath = true
        mockProjectFinder.stubbedFindOpenWorkspacePathResult = nil
        assertEqualError("Could not detect your project. Enter one in the companion app.")
    }

    func test_getProjectPath_shouldReturnAutomaticProjectPath() {
        preferences.automaticallyDetectProjectPath = true
        mockProjectFinder.stubbedFindOpenWorkspacePathResult = projectFolder
        assertEqualProjectPath(projectPath)
    }

    // MARK: - Helpers

    class MockProjectFinder: XcodeProjectPathFinder {

        var invokedFindOpenWorkspacePath = false
        var invokedFindOpenWorkspacePathCount = 0
        var stubbedFindOpenWorkspacePathResult: String!

        override func findOpenWorkspacePath() -> String? {
            invokedFindOpenWorkspacePath = true
            invokedFindOpenWorkspacePathCount += 1
            return stubbedFindOpenWorkspacePathResult
        }
    }

    func assertEqualProjectPath(_ expected: String, line: UInt = #line) {
        let result = try? finder.getProjectPath()
        XCTAssertEqual(result?.path, expected, line: line)
    }

    func assertEqualError(_ expected: String, line: UInt = #line) {
        do {
            _ = try finder.getProjectPath()
            XCTFail("Should have thrown an error")
        } catch {
            XCTAssertEqual((error as NSError).localizedDescription, expected, line: line)
        }
    }
}
