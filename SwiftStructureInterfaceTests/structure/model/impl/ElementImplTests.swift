import XCTest
@testable import SwiftStructureInterface

class ElementImplTests: XCTestCase {

    func test_appendExtraChildren_shouldIgnoreNonElements() {
        var children = [Element]()
        ElementImpl.appendChild("", to: &children)
        XCTAssert(children.isEmpty)
    }

    func test_appendExtraChildren_shouldIgnoreNil() {
        var children = [Element]()
        ElementImpl.appendChild(nil, to: &children)
        XCTAssert(children.isEmpty)
    }

    func test_appendExtraChildren_shouldAppendElement() {
        var children = [Element]()
        ElementImpl.appendChild(testElement, to: &children)
        XCTAssert(children[0] === testElement)
    }

    func test_appendExtraChildren_shouldAppendElements() {
        var children = [Element]()
        ElementImpl.appendChild([testElement], to: &children)
        XCTAssert(children[0] === testElement)
    }
}
