import XCTest
@testable import SwiftStructureInterface

class CachingResolverTests: XCTestCase {

    var resolver: CachingResolver!
    var spy: ResolverSpy!

    override func setUp() {
        super.setUp()
        spy = ResolverSpy()
        resolver = CachingResolver(spy)
        spy.stubbedResolveResult = testTupleTypeElement
    }

    override func tearDown() {
        resolver = nil
        spy = nil
        super.tearDown()
    }

    func test_resolve_shouldResolveWhenNoCachedElement() {
        XCTAssert(resolve(testElement) === testTupleTypeElement)
        XCTAssert(spy.invokedResolveParameters?.element === testElement)
    }

    func test_resolve_shouldReturnCachedElementAfterResolvingTheSameElement() {
        resolve(testElement)
        XCTAssert(resolve(testElement) === testTupleTypeElement)
        XCTAssertEqual(spy.invokedResolveCount, 1)
    }

    func test_resolve_shouldReturnNotReturnCachedElementAfterResolvingADifferentElement() {
        resolve(testArrayType)
        XCTAssert(resolve(testElement) === testTupleTypeElement)
        XCTAssertEqual(spy.invokedResolveCount, 2)
    }

    func test_resolve_shouldReturnReturnCachedElementAfterResolvingTheSameElementEvenWhenItResolvedToNil() {
        spy.stubbedResolveResult = nil
        resolve(testElement)
        XCTAssertNil(resolve(testElement))
        XCTAssertEqual(spy.invokedResolveCount, 1)
    }

    func test_resolve_shouldReturnReturnCachedElementWhenElementIsDifferentInstanceButTextIsTheSame() throws {
        let element1 = try ElementParser.parseType("Int")
        let element2 = try ElementParser.parseType("Int")
        resolve(element1)
        resolve(element2)
        XCTAssertEqual(spy.invokedResolveCount, 1)
    }

    @discardableResult
    private func resolve(_ element: Element = testElement) -> Element? {
        return resolver.resolve(element)
    }
}
