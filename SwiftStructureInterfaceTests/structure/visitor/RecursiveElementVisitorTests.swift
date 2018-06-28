import XCTest
@testable import SwiftStructureInterface

class RecursiveElementVisitorTests: XCTestCase {

    var mockVisitor: MockRecursiveVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockRecursiveVisitor()
    }

    override func tearDown() {
        mockVisitor = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldRecursivelyVisitChildren() throws {
        let file = try parseFile()
        file.accept(mockVisitor)
        XCTAssertEqual(mockVisitor.invokedVisitFileCount, 1)
        XCTAssertEqual(mockVisitor.invokedVisitTypeDeclarationCount, 1)
        XCTAssertEqual(mockVisitor.invokedVisitFunctionDeclarationCount, 2)
    }

    // MARK: - Helpers

    private func parseFile() throws -> File {
        return try ParserTestHelper.parseFile(from: getNestedClassString())
    }

    private func getNestedClassString() -> String {
        return """
        protocol A: B {
            func a() {
                func innerA() {}
            }
        }
        """
    }
}
