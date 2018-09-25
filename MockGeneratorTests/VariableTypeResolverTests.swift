import XCTest
import TestHelper
import AST
import Resolver
import UseCases
@testable import MockGenerator

class VariableTypeResolverTests: XCTestCase {
    func test_shouldResolveTypeAnnotation() {
        assertResolve("var a: A", "A")
    }

    func test_shouldResolveInitializerWithLiteral() {
        assertResolve("var a = \"\"", "String")
        assertResolve("var a = 0", "Int")
        assertResolve("var a = true", "Bool")
        assertResolve("var a = 0.1", "Double")
    }

    func test_shouldResolveInitializerWithArrayLiteral() {
        assertResolveArray("var a = [\"abc\"]", "String")
        assertResolveArray("var a = [0, 1]", "Int")
        assertResolveArray("var a = [true]", "Bool")
        assertResolveArray("var a = [0.1]", "Double")
        assertResolveNil("var a = []")
    }

    func test_shouldResolveInitializerWithDictionaryLiteral() {
        assertResolveDict("var a = [\"abc\": 0]", "String", "Int")
        assertResolveNil("var a = [:]")
    }

    func test_shouldResolveInitializerWithArrayFunctionCall() {
        assertResolveArray("var a = [ClassType]()", "ClassType")
    }

    func test_shouldResolveToClassType() {
        assertResolve("var a = ClassType()", "ClassType")
    }

    func test_shouldResolveToStructType() {
        assertResolve("var a = StructType()", "StructType")
    }

    func test_shouldResolveToEnumType() {
        assertResolve("var a = EnumType()", "EnumType")
    }

    func test_shouldResolveInitializerWithDictionaryFunctionCall() {
        assertResolveDict("var a = [ClassType: ClassType]()", "ClassType", "ClassType")
    }

    func test_shouldNotResolveToUnresolvableItem() {
        assertResolveNil("var a = cannotResolve")
    }

    func test_shouldResolveAsPattern() {
        assertResolve("var a = a as A", "A")
    }

    func test_shouldResolveAsArrayPattern() {
        assertResolveArray("var a = a as [ClassType]", "ClassType")
    }

    func test_shouldResolveIsPattern() {
        assertResolve("var a = a is A", "Bool")
    }

    private func assertResolve(_ text: String, _ expected: String, line: UInt = #line) {
        XCTAssertEqual(try resolve(text)?.text, expected, line: line)
    }

    private func assertResolveArray(_ text: String, _ expected: String, line: UInt = #line) {
        let resolved = try! resolve(text)
        XCTAssert(resolved is UseCasesArrayType, line: line)
        let array = resolved as? UseCasesArrayType
        XCTAssertEqual(array?.text, "[\(expected)]", line: line)
        XCTAssertEqual(array?.type.text, expected, line: line)
    }

    private func assertResolveDict(_ text: String, _ expectedKey: String, _ expectedValue: String, line: UInt = #line) {
        let resolved = try! resolve(text)
        XCTAssert(resolved is UseCasesDictionaryType, line: line)
        let dict = resolved as? UseCasesDictionaryType
        XCTAssertEqual(dict?.text, "[\(expectedKey): \(expectedValue)]", line: line)
        XCTAssertEqual(dict?.keyType.text, expectedKey, line: line)
        XCTAssertEqual(dict?.valueType.text, expectedValue, line: line)
    }

    private func assertResolveNil(_ text: String, line: UInt = #line) {
        XCTAssertNil(try resolve(text), line: line)
    }

    private func resolve(_ text: String) throws -> UseCasesType? {
        let fullText = """
        \(text)
        func returnMethod() -> ReturnMethodType {}
        class ClassType {}
        struct StructType {}
        enum EnumType {}
        """
        return VariableTypeResolver.resolve(try parse(fullText), resolver: ResolverFactory.createResolver(filePaths: []))
    }

    private func parse(_ text: String) throws -> Element {
        return try ParserTestHelper.parseFile(from: text).children[0]
    }
}
