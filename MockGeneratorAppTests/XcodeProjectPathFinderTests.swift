import XCTest
@testable import MockGeneratorApp

class XcodeProjectPathFinderTests: XCTestCase {

    var finder: TestFinder!

    override func setUp() {
        super.setUp()
        finder = TestFinder()
    }

    // MARK: - findOpenProjectPath

    func test_findOpenProjectPath_shouldReturnNil_whenNoWorkspaceIsFound() {
        finder.stubbedFindOpenWorkspacePathResult = nil
        XCTAssertNil(finder.findOpenProjectPath())
    }

    func test_findOpenProjectPath_shouldReturnParentPath_whenWorkspaceIsFound() {
        finder.stubbedFindOpenWorkspacePathResult = "/path/to/workspace.xcworkspace"
        XCTAssertEqual(finder.findOpenProjectPath()?.path, "/path/to")
    }

    func test_findOpenProjectPath_shouldReturnParentPath_whenProjectIsFound() {
        finder.stubbedFindOpenWorkspacePathResult = "/path/to/project.xcodeproj"
        XCTAssertEqual(finder.findOpenProjectPath()?.path, "/path/to")
    }

    func test_findOpenProjectPath_shouldReturnParentPath_whenRootProjectIsFound() {
        finder.stubbedFindOpenWorkspacePathResult = "/project.xcodeproj"
        XCTAssertEqual(finder.findOpenProjectPath()?.path, "/")
    }

    func test_findOpenProjectPath_shouldReturnNil_whenLocalProjectIsFound() {
        finder.stubbedFindOpenWorkspacePathResult = "project.xcodeproj"
        XCTAssertNil(finder.findOpenProjectPath())
    }

    // MARK: - Helpers

    class TestFinder: XcodeProjectPathFinder {

        var invokedFindOpenWorkspacePath = false
        var invokedFindOpenWorkspacePathCount = 0
        var stubbedFindOpenWorkspacePathResult: String!

        override func findOpenWorkspacePath() -> String? {
            invokedFindOpenWorkspacePath = true
            invokedFindOpenWorkspacePathCount += 1
            return stubbedFindOpenWorkspacePathResult
        }
    }
}

