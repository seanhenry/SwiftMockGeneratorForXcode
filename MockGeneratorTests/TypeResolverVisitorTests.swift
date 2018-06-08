import XCTest
import UseCases
@testable import SwiftStructureInterface
@testable import MockGenerator

class TypeResolverVisitorTests: XCTestCase {

    var visitor: TypeResolverVisitor!
    var genericClause: GenericParameterClause!
    var classType: TypeIdentifier!
    var type: Type!
    var array: ArrayType!
    var dictionary: DictionaryType!
    var optional: OptionalType!
    var mockResolveUtil: MockResolveUtil!

    override func setUp() {
        super.setUp()
        genericClause = GenericParameterClauseImpl(text: "<T>", children: [], offset: 0, length: 0, parameters: [])
        classType = SwiftTypeIdentifier(text: "Int", children: [], offset: 0, length: 0, typeName: "Int", genericArguments: [], parentType: nil)
        type = createType("T")
        array = createArray("[T]", type)
        dictionary = createDictionary("[T: T]", type, type)
        optional = createOptional("T?", type)
        mockResolveUtil = MockResolveUtil()
        visitor = TypeResolverVisitor(resolveUtil: mockResolveUtil)
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
        optional = nil
        super.tearDown()
    }

    // MARK: - visit

    func test_visit_shouldTransformTypeToAnyWhenResolvingToGenericType() {
        stubResolveToGenericClause()
        type.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, type.text)
    }

    func test_visit_shouldTransformToSameTypeWhenNotResolvingToGenericType() {
        stubResolveToNormalType()
        type.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, type.text)
    }

    func test_visit_shouldTransformToNilWhenCannotResolveType() {
        type.accept(visitor)
        XCTAssertNil(visitor.resolvedType?.text)
    }

    // MARK: - array

    func test_visit_shouldTransformArrayTypeToAnyWhenResolvingToGenericType() {
        stubResolveToGenericClause()
        array.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, array.text)
    }

    func test_visit_shouldNotTransformArrayWhenResolvingToNormalType() {
        stubResolveToNormalType()
        array.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, array.text)
    }

    func test_visit_shouldTransformArrayToSameTypeWhenCannotResolveType() {
        array.accept(visitor)
        XCTAssertNil(visitor.resolvedType?.text)
    }

    // MARK: - dictionary

    func test_visit_shouldTransformDictionaryTypeToAnyWhenResolvingToGenericType() {
        stubResolveToGenericClause()
        dictionary.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, dictionary.text)
    }

    func test_visit_shouldNotTransformDictionaryTypeWhenResolvingToNormalType() {
        stubResolveToNormalType()
        dictionary.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, dictionary.text)
    }

    func test_visit_shouldTransformDictionaryToSameTypeWhenCannotResolveType() {
        dictionary.accept(visitor)
        XCTAssertNil(visitor.resolvedType?.text)
    }

    // MARK: - optional

    func test_visit_shouldTransformOptionalTypeToAnyWhenResolvingToGenericType() {
        stubResolveToGenericClause()
        optional.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, optional.text)
    }

    func test_visit_shouldNotTransformOptionalTypeToAnyWhenResolvingToNormalType() {
        optional.accept(visitor)
        XCTAssertNil(visitor.resolvedType?.text)
    }

    // MARK: - Typealias

    func test_visit_shouldHaveNilTypeWhenCannotResolve() {
        type.accept(visitor)
        XCTAssertNil(visitor.resolvedType?.text)
    }

    func test_visit_shouldTransformToTypealiasType() {
        let assignment = TypealiasAssignmentImpl(text: "= T", children: [], offset: 0, length: 0, type: type)
        let typeAlias = TypealiasImpl(text: "typealias A = T", children: [], offset: 0, length: 0, name: "A", typealiasAssignment: assignment)
        mockResolveUtil.stubbedResolveResult = typeAlias
        let aliasedType = createType("A")
        aliasedType.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, "T")
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

    private func createType(_ name: String) -> Type {
        return TypeImpl(text: name, children: [], offset: 0, length: 0)
    }

    private func createDictionary(_ name: String, _ keyType: Type, _ valueType: Type) -> DictionaryType {
        return SwiftDictionaryType(text: name, children: [], offset: 0, length: 0, keyType: keyType, valueType: valueType)
    }

    private func createArray(_ name: String, _ elementType: Type) -> ArrayType {
        return SwiftArrayType(text: name, children: [], offset: 0, length: 0, elementType: elementType)
    }

    private func createOptional(_ name: String, _ type: Type) -> OptionalType {
        return SwiftOptionalType(text: name, children: [], offset: 0, length: 0, type: type)
    }

    private func stubResolveToGenericClause() {
        mockResolveUtil.stubbedResolveResult = genericClause
    }

    private func stubResolveToNormalType() {
        mockResolveUtil.stubbedResolveResult = classType
    }
}
