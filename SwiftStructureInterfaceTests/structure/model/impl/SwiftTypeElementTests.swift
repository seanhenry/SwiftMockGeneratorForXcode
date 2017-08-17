import XCTest
@testable import SwiftStructureInterface

class SwiftTypeElementTests: XCTestCase {

    var element: SwiftTypeElement!
    private var mockVisitor: MockElementVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockElementVisitor()
        element = emptySwiftTypeElement
    }

    override func tearDown() {
        element = nil
        mockVisitor = nil
        super.tearDown()
    }

    // MARK: - accept

    func test_accept_shouldSendItself() {
        element.accept(mockVisitor)
        XCTAssert(mockVisitor.invokedVisitSwiftTypeElementParameters?.element === element)
        XCTAssert(mockVisitor.invokedVisitSwiftElementParameters?.element === element)
    }
}
