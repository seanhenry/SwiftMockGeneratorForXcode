import XCTest
@testable import SwiftStructureInterface

class ElementImplTests: XCTestCase {

    func test_init_shouldAddSelfAsParentToAllChildren() {
        let element1 = ElementImpl(children: [])
        let element2 = ElementImpl(children: [])
        let element3 = ElementImpl(children: [])
        let parent = ElementImpl(children: [element1, element2, element3])
        XCTAssert(element1.parent === parent)
        XCTAssert(element2.parent === parent)
        XCTAssert(element3.parent === parent)
    }

    func test_isIdenticalTo_shouldReturnTrueWhenInstancesAreIdentical() {
        let element = ElementImpl.emptyElement()
        XCTAssert(element.isIdentical(to: element))
    }

    func test_isIdenticalTo_shouldReturnFalseWhenInstancesAreNotIdentical() {
        let element1 = ElementImpl.emptyElement()
        let element2 = ElementImpl.emptyElement()
        XCTAssertFalse(element1.isIdentical(to: element2))
        XCTAssertFalse(element2.isIdentical(to: element1))
    }
}
