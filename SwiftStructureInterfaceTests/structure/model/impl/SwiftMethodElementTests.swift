import XCTest
@testable import SwiftStructureInterface

class SwiftMethodElementTests: XCTestCase {

    var element: SwiftMethodElement!
    private var mockVisitor: MockElementVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockElementVisitor()
        element = emptySwiftMethod
    }

    override func tearDown() {
        element = nil
        mockVisitor = nil
        super.tearDown()
    }

    // MARK: - accept

    func test_accept_shouldSendItself() {
        element.accept(mockVisitor)
        XCTAssert(mockVisitor.invokedVisitSwiftMethodElementParameters?.element === element)
        XCTAssert(mockVisitor.invokedVisitSwiftElementParameters?.element === element)
    }
}
