import XCTest
import AST
import TestHelper
import Resolver
import SwiftyKit
@testable import MockGenerator

class TypeResolverVisitorTests: XCTestCase {

    var visitor: TypeResolverVisitor!
    var genericClause: GenericParameterClause!
    var classType: TypeIdentifier!
    var type: Type!
    var array: ArrayType!
    var dictionary: DictionaryType!
    var optional: OptionalType!
    var resolverSpy: ResolverSpy!

    override func setUp() {
        super.setUp()
        genericClause = try! ParserTestHelper.parseGenericParameterClause("<T>")
        classType = (try! ParserTestHelper.parseType("Int")) as? TypeIdentifier
        type = createType("T")
        array = createArray(type)
        dictionary = createDictionary(type, type)
        optional = createOptional(type)
        resolverSpy = ResolverSpy()
        visitor = TypeResolverVisitor(resolver: resolverSpy)
    }

    override func tearDown() {
        visitor = nil
        resolverSpy = nil
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
        let typeAlias = try! ParserTestHelper.parseTypealias("typealias A = T")
        resolverSpy.stubbedResolveResult = typeAlias
        let aliasedType = createType("A")
        aliasedType.accept(visitor)
        XCTAssertEqual(visitor.resolvedType?.text, "T")
    }

    // MARK: - Helpers

    private func createType(_ name: String) -> Type {
        return try! ParserTestHelper.parseType(name)
    }

    private func createDictionary(_ keyType: Type, _ valueType: Type) -> DictionaryType {
        return try! ParserTestHelper.parseType("[\(keyType.text): \(valueType.text)]") as! DictionaryType
    }

    private func createArray(_ elementType: Type) -> ArrayType {
        return try! ParserTestHelper.parseType("[\(elementType.text)]") as! ArrayType
    }

    private func createOptional(_ type: Type) -> OptionalType {
        return try! ParserTestHelper.parseType("\(type.text)?") as! OptionalType
    }

    private func stubResolveToGenericClause() {
        resolverSpy.stubbedResolveResult = genericClause
    }

    private func stubResolveToNormalType() {
        resolverSpy.stubbedResolveResult = classType
    }
}
