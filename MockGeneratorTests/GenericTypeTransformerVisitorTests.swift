import XCTest
@testable import SwiftStructureInterface
@testable import MockGenerator

class GenericTypeTransformerVisitorTests: XCTestCase {

    var visitor: GenericTypeTransformerVisitor!
    let genericResolved = SwiftGenericParameterClause(text: "", children: [], offset: 0, length: 0)
    let classResolved = SwiftTypeIdentifier(text: "T", children: [], offset: 0, length: 0, type: SwiftType.errorType, genericArguments: [])
    let genericType = SwiftType(text: "T", children: [], offset: 0, length: 0)
    let type = SwiftType(text: "Int", children: [], offset: 0, length: 0)
    var mockResolveUtil: MockResolveUtil!

    override func setUp() {
        super.setUp()
        mockResolveUtil = MockResolveUtil()
        visitor = GenericTypeTransformerVisitor(resolveUtil: mockResolveUtil)
    }

    override func tearDown() {
        visitor = nil
        mockResolveUtil = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldTransformTypeToAnyWhenResolvingToGenericType() {
        mockResolveUtil.stubbedResolveResult = genericResolved
        visitor.visitType(genericType)
        XCTAssertEqual(visitor.type?.typeName, "Any")
    }

    func test_visit_shouldTransformToSameTypeWhenNotResolvingToGenericType() {
        mockResolveUtil.stubbedResolveResult = classResolved
        visitor.visitType(type)
        XCTAssertEqual(visitor.type?.typeName, type.text)
    }

    func test_visit_shouldTransformToSameTypeWhenCannotResolveType() {
        mockResolveUtil.stubbedResolveResult = nil
        visitor.visitType(type)
        XCTAssertEqual(visitor.type?.typeName, type.text)
    }

    // MARK: - Helpers

    class MockResolveUtil: ResolveUtil {

        var invokedResolve = false
        var invokedResolveCount = 0
        var invokedResolveParameters: (element: Element, Void)?
        var invokedResolveParametersList = [(element: Element, Void)]()
        var stubbedResolveResult: Element!

        override func resolve(_ element: Element) -> Element? {
            invokedResolve = true
            invokedResolveCount += 1
            invokedResolveParameters = (element, ())
            invokedResolveParametersList.append((element, ()))
            return stubbedResolveResult
        }
    }
}
