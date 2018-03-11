import XCTest
@testable import SwiftStructureInterface

class SwiftElementTests: XCTestCase {

    var element: SwiftElement!
    private var mockVisitor: MockElementVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockElementVisitor()
        element = emptyElement
    }

    override func tearDown() {
        element = nil
        mockVisitor = nil
        super.tearDown()
    }

    // MARK: - init

    func test_init_shouldSetSelfAsParentToAllChildren() {
        let child0 = createElement()
        let child1 = createElement()
        let element = SwiftElement(text: "", children: [child0, child1], offset: 0, length: 0)
        XCTAssert(child0.parent === element)
        XCTAssert(child1.parent === element)
    }

    // MARK: - Helpers
    
    func createElement() -> Element {
        return SwiftElement(text: "", children: [], offset: 0, length: 0)
    }
}
