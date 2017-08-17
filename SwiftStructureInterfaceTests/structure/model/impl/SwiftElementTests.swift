import XCTest
@testable import SwiftStructureInterface

class SwiftElementTests: XCTestCase {

    var element: SwiftElement!
    private var mockVisitor: MockElementVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockElementVisitor()
        element = emptySwiftElement
    }

    override func tearDown() {
        element = nil
        mockVisitor = nil
        super.tearDown()
    }

    // MARK: - accept

    func test_accept_shouldSendItself() {
        element.accept(mockVisitor)
        XCTAssert(mockVisitor.invokedVisitSwiftElementParameters?.element === element)
    }
}
