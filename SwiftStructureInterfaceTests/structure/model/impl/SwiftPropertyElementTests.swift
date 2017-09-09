import XCTest
@testable import SwiftStructureInterface

class SwiftPropertyElementTests: XCTestCase {

    var element: SwiftPropertyElement!
    private var mockVisitor: MockElementVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockElementVisitor()
        element = emptySwiftProperty
    }

    override func tearDown() {
        element = nil
        mockVisitor = nil
        super.tearDown()
    }

    // MARK: - accept

    func test_accept_shouldAcceptSelf() {
        element.accept(mockVisitor)
        XCTAssert(mockVisitor.invokedVisitSwiftPropertyElementParameters?.element === element)
        XCTAssert(mockVisitor.invokedVisitSwiftElementParameters?.element === element)
    }
}
