import XCTest
@testable import SwiftStructureInterface

class SwiftElementTests: XCTestCase {

    var element: ElementImpl!
    private var mockVisitor: MockElementVisitor!

    override func setUp() {
        super.setUp()
        mockVisitor = MockElementVisitor()
        element = ElementImpl.emptyElement
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
        let element = ElementImpl(children: [child0, child1])
        XCTAssert(child0.parent === element)
        XCTAssert(child1.parent === element)
    }

    // MARK: - Helpers
    
    func createElement() -> Element {
        return ElementImpl.emptyElement
    }
}
