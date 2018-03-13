import XCTest
import UseCases
@testable import SwiftStructureInterface
@testable import MockGenerator

class GenericTypeTransformerVisitorTests: XCTestCase {

    var visitor: GenericTypeTransformerVisitor!
    var genericClause: GenericParameterClause!
    var classType: TypeIdentifier!
    var type: Type!
    var array: ArrayType!
    var dictionary: DictionaryType!
    var mockResolveUtil: MockResolveUtil!

    override func setUp() {
        super.setUp()
        genericClause = SwiftGenericParameterClause(text: "<T>", children: [], offset: 0, length: 0)
        classType = SwiftTypeIdentifier(text: "Int", children: [], offset: 0, length: 0, type: SwiftType.errorType, genericArguments: [])
        type = SwiftType(text: "T", children: [], offset: 0, length: 0)
        array = createArray("[T]", type)
        dictionary = createDictionary("[T: T]", type, type)
        mockResolveUtil = MockResolveUtil()
        visitor = GenericTypeTransformerVisitor(resolveUtil: mockResolveUtil)
    }

    override func tearDown() {
        visitor = nil
        mockResolveUtil = nil
        genericClause = nil
        classType = nil
        type = nil
        array = nil
        type = nil
        dictionary = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldTransformTypeToAnyWhenResolvingToGenericType() {
        stubResolveToGenericClause()
        type.accept(visitor)
        XCTAssertEqual(visitor.type?.typeName, "Any")
    }

    func test_visit_shouldTransformToSameTypeWhenNotResolvingToGenericType() {
        mockResolveUtil.stubbedResolveResult = classType
        type.accept(visitor)
        XCTAssertEqual(visitor.type?.typeName, type.text)
    }

    func test_visit_shouldTransformToSameTypeWhenCannotResolveType() {
        type.accept(visitor)
        XCTAssertEqual(visitor.type?.typeName, type.text)
    }

    // MARK: - array

    func test_visit_shouldTransformArrayTypeToAnyWhenResolvingToGenericType() {
        stubResolveToGenericClause()
        array.accept(visitor)
        XCTAssertEqual(visitor.type?.typeName, "[Any]")
    }

    func test_visit_shouldTransformArrayTypeToAnyWhenResolvingToNormalType() {
        array.accept(visitor)
        XCTAssertEqual(visitor.type?.typeName, array.text)
    }

    // MARK: - dictionary

    func test_visit_shouldTransformDictionaryTypeToAnyWhenResolvingToGenericType() {
        stubResolveToGenericClause()
        dictionary.accept(visitor)
        XCTAssertEqual(visitor.type?.typeName, "[Any: Any]")
    }

    func test_visit_shouldTransformDictionaryTypeToAnyWhenResolvingToNormalType() {
        dictionary.accept(visitor)
        XCTAssertEqual(visitor.type?.typeName, dictionary.text)
    }

    // MARK: - Nested

    func test_visit_shouldTransformNestedDictionaryType() {
        let dictContainingArray = createDictionary("[T: [U]]", type, array)
        stubResolveToGenericClause()
        dictContainingArray.accept(visitor)
        XCTAssertEqual(visitor.type?.typeName, "[Any: [Any]]")
    }

    func test_visit_shouldTransformNestedArrayType() {
        let arrayContainingDict = createArray("[[T: U]]", dictionary)
        stubResolveToGenericClause()
        arrayContainingDict.accept(visitor)
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

    private func createDictionary(_ name: String, _ keyType: Type, _ valueType: Type) -> DictionaryType {
        return SwiftDictionaryType(text: name, children: [], offset: 0, length: 0, keyType: keyType, valueType: valueType)
    }

    private func createArray(_ name: String, _ elementType: Type) -> ArrayType {
        return SwiftArrayType(text: name, children: [], offset: 0, length: 0, elementType: elementType)
    }

    private func stubResolveToGenericClause() {
        mockResolveUtil.stubbedResolveResult = genericClause
    }
}
