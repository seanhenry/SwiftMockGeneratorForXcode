import XCTest
import UseCases
@testable import SwiftStructureInterface
@testable import MockGenerator

class GenericTypeTransformerVisitorTests: XCTestCase {

    var visitor: GenericTypeTransformerVisitor!
    var genericClause: SwiftGenericParameterClause!
    var classType: SwiftTypeIdentifier!
    var genericType: SwiftType!
    var genericType2: SwiftType!
    var genericArrayType: SwiftArrayType!
    var nestedArrayType: SwiftArrayType!
    var genericDictionaryType: SwiftDictionaryType!
    var nestedDictionaryType: SwiftDictionaryType!
    var type: SwiftType!
    var mockResolveUtil: MockResolveUtil!

    override func setUp() {
        super.setUp()
        genericClause = SwiftGenericParameterClause(text: "<T>", children: [], offset: 0, length: 0)
        classType = SwiftTypeIdentifier(text: "Int", children: [], offset: 0, length: 0, type: SwiftType.errorType, genericArguments: [])
        genericType = SwiftType(text: "T", children: [], offset: 0, length: 0)
        genericType2 = SwiftType(text: "U", children: [], offset: 0, length: 0)
        genericArrayType = SwiftArrayType(text: "[T]", children: [], offset: 0, length: 0, elementType: genericType)
        genericDictionaryType = SwiftDictionaryType(text: "[T: U]", children: [], offset: 0, length: 0, keyType: genericType, valueType: genericType2)
        nestedDictionaryType = SwiftDictionaryType(text: "[T: [U]]", children: [], offset: 0, length: 0, keyType: genericType, valueType: genericArrayType)
        nestedArrayType = SwiftArrayType(text: "[[T: U]]", children: [], offset: 0, length: 0, elementType: genericDictionaryType)
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
        genericType2 = nil
        genericDictionaryType = nil
        nestedArrayType = nil
        nestedDictionaryType = nil
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

    func test_visit_shouldTransformArrayTypeToAnyWhenResolvingToNormalType() {
        mockResolveUtil.stubbedResolveResult = nil
        visitor.visitArrayType(genericArrayType)
        XCTAssertEqual(visitor.type?.typeName, genericArrayType.text)
    }

    // MARK: - dictionary

    func test_visit_shouldTransformDictionaryTypeToAnyWhenResolvingToGenericType() {
        mockResolveUtil.stubbedResolveResult = genericClause
        visitor.visitDictionaryType(genericDictionaryType)
        XCTAssertEqual(visitor.type?.typeName, "[Any: Any]")
    }

    func test_visit_shouldTransformDictionaryTypeToAnyWhenResolvingToNormalType() {
        mockResolveUtil.stubbedResolveResult = nil
        visitor.visitDictionaryType(genericDictionaryType)
        XCTAssertEqual(visitor.type?.typeName, genericDictionaryType.text)
    }

    // MARK: - Nested

    func test_visit_shouldTransformNestedDictionaryType() {
        mockResolveUtil.stubbedResolveResult = genericClause
        visitor.visitDictionaryType(nestedDictionaryType)
        XCTAssertEqual(visitor.type?.typeName, "[Any: [Any]]")
    }

    func test_visit_shouldTransformNestedArrayType() {
        mockResolveUtil.stubbedResolveResult = genericClause
        visitor.visitArrayType(nestedArrayType)
        XCTAssertEqual(visitor.type?.typeName, "[[Any: Any]]")
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
