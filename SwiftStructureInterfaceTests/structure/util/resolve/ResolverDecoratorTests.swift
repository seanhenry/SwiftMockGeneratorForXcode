import XCTest
@testable import SwiftStructureInterface

class ResolverDecoratorTests: XCTestCase {

    var decorator: ResolverDecorator!
    var spy: ResolverSpy!

    override func setUp() {
        super.setUp()
        spy = ResolverSpy()
        decorator = ResolverDecorator(spy)
    }

    override func tearDown() {
        decorator = nil
        spy = nil
        super.tearDown()
    }

    func test_shouldReturnResolvedElementFromDecorator() {
        spy.stubbedResolveResult = testElement
        XCTAssert(decorator.resolve(testElement) === testElement)
    }
}
