import XCTest
import UseCases
@testable import SwiftStructureInterface
@testable import MockGenerator

class GenericTypeTransformerVisitorTests: XCTestCase {

    var visitor: GenericTypeTransformerVisitor!
    var genericClause: SwiftGenericParameterClause!
    var classType: SwiftTypeIdentifier!
    var genericType: SwiftType!
    var genericArrayType: SwiftArrayType!
    var type: SwiftType!
    var mockResolveUtil: MockResolveUtil!

    override func setUp() {
        super.setUp()
        genericClause = SwiftGenericParameterClause(text: "<T>", children: [], offset: 0, length: 0)
        classType = SwiftTypeIdentifier(text: "Int", children: [], offset: 0, length: 0, type: SwiftType.errorType, genericArguments: [])
        genericType = SwiftType(text: "T", children: [], offset: 0, length: 0)
        genericArrayType = SwiftArrayType(text: "[T]", children: [], offset: 0, length: 0, elementType: genericType)
        type = SwiftType(text: "Int", children: [], offset: 0, length: 0)
        mockResolveUtil = MockResolveUtil()
        visitor = GenericTypeTransformerVisitor(resolveUtil: mockResolveUtil)
    }

    override func tearDown() {
        visitor = nil
        mockResolveUtil = nil
        genericClause = nil
        classType = nil
        genericType = nil
        genericArrayType = nil
        type = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldTransformTypeToAnyWhenResolvingToGenericType() {
        mockResolveUtil.stubbedResolveResult = genericClause
        visitor.visitType(genericType)
        XCTAssertEqual(visitor.type?.typeName, "Any")
    }

    func test_visit_shouldTransformToSameTypeWhenNotResolvingToGenericType() {
        mockResolveUtil.stubbedResolveResult = classType
        visitor.visitType(type)
        XCTAssertEqual(visitor.type?.typeName, type.text)
    }

    func test_visit_shouldTransformToSameTypeWhenCannotResolveType() {
        mockResolveUtil.stubbedResolveResult = nil
        visitor.visitType(type)
        XCTAssertEqual(visitor.type?.typeName, type.text)
    }

    // MARK: - array

    func test_visit_shouldTransformArrayTypeToAnyWhenResolvingToGenericType() {
        mockResolveUtil.stubbedResolveResult = genericClause
        visitor.visitArrayType(genericArrayType)
        XCTAssertEqual(visitor.type?.typeName, "[Any]")
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
