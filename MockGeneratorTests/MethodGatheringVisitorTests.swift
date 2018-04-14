import XCTest
import SourceKittenFramework
import UseCases
@testable import SwiftStructureInterface
@testable import MockGenerator

class MethodGatheringVisitorTests: XCTestCase {

    var visitor: MethodGatheringVisitor!

    override func setUp() {
        super.setUp()
        visitor = MethodGatheringVisitor()
        ResolveUtil.sameFileCursorInfoRequest = SKCursorInfoRequest(files: [])
        ResolveUtil.cursorInfoRequest = SKCursorInfoRequest(files: [])
    }

    override func tearDown() {
        visitor = nil
        super.tearDown()
    }

    // MARK: - visit
    
    func test_shouldTransformUnsupportedType() {
        assertTypeIs("(A, B)", UseCasesTypeIdentifier.self, "(A, B)")
    }

    func test_shouldTransformTypeIdentifier() {
        assertTypeIs("Type", UseCasesTypeIdentifier.self, "Type")
    }

    func test_shouldTransformGenericType() {
        assertTypeIs("Type<A>", UseCasesGenericType.self, "Type<A>")
    }

    func test_shouldTransformGenericTypeWithMultipleArguments() {
        assertTypeIs("Type<A, B>", UseCasesGenericType.self, "Type<A, B>")
    }

    func test_shouldTransformGenericTypeWithNestedTypes() {
        assertTypeIs("Type<A.B>", UseCasesGenericType.self, "Type<A.B>")
    }

    func test_shouldTransformNestedTypes() {
        assertTypeIs("A.B.C", UseCasesTypeIdentifier.self, "A.B.C")
        let type = transformType("A.B", UseCasesTypeIdentifier.self)
        XCTAssertEqual(type.identifiers[0] as! String, "A")
        XCTAssertEqual(type.identifiers[1] as! String, "B")
    }

    func test_shouldTransformArrayType() {
        let type = transformType("[Type]", UseCasesArrayType.self)
        XCTAssertEqual(type.text, "[Type]")
        XCTAssert(type.type is UseCasesTypeIdentifier)
    }

    func test_shouldTransformArrayTypeWithComplexType() {
        let type = transformType("[[Int]]", UseCasesArrayType.self)
        XCTAssertEqual(type.text, "[[Int]]")
        XCTAssert(type.type is UseCasesArrayType)
        XCTAssertEqual(type.type.text, "[Int]")
        let inner = type.type as! UseCasesArrayType
        XCTAssert(inner.type is UseCasesTypeIdentifier)
    }

    func test_shouldTransformDictionaryType() {
        let type = transformType("[A: B]", UseCasesDictionaryType.self)
        XCTAssertEqual(type.text, "[A: B]")
        XCTAssert(type.keyType is UseCasesTypeIdentifier)
        XCTAssert(type.valueType is UseCasesTypeIdentifier)
    }

    func test_shouldTransformDictionaryTypeWithComplexTypes() {
        let type = transformType("[[A]: [B: C]]", UseCasesDictionaryType.self)
        XCTAssertEqual(type.text, "[[A]: [B: C]]")
        XCTAssert(type.keyType is UseCasesArrayType)
        XCTAssert(type.valueType is UseCasesDictionaryType)
    }

    func test_shouldTransformOptionalType() {
        let type = transformType("A?", UseCasesOptionalType.self)
        XCTAssertEqual(type.text, "A?")
        XCTAssert(type.type is UseCasesTypeIdentifier)
    }

    func test_shouldTransformComplexOptionalType() {
        let type = transformType("[A]?", UseCasesOptionalType.self)
        XCTAssertEqual(type.text, "[A]?")
        XCTAssert(type.type is UseCasesArrayType)
    }

    // TODO: support IUO properly
    // TODO: support Optional<Style>
    func test_shouldTransformIUO() {
        let type = transformType("A!", UseCasesOptionalType.self)
        XCTAssertEqual(type.text, "A!")
        XCTAssert(type.isImplicitlyUnwrapped)
        XCTAssert(type.implicitlyUnwrapped)
    }

    private func assertTypeIs<T: UseCasesType>(_ input: String, _ t: T.Type, _ text: String, line: UInt = #line) {
        let type = FileParser(fileContents: input).parseType()
        let result = MethodGatheringVisitor.transformType(type)
        XCTAssert(result is T, line: line)
        XCTAssertEqual(result.text, text, line: line)
    }

    private func transformType<T: UseCasesType>(_ input: String, _ t: T.Type) -> T {
        let type = FileParser(fileContents: input).parseType()
        return MethodGatheringVisitor.transformType(type) as! T
    }

    func test_visit_shouldTransformProtocolMethod() {
        let method = transformMethod("func a()")
        XCTAssertEqual(method.name, "a")
        XCTAssert(method.genericParameters.isEmpty)
        XCTAssert(method.parametersList.isEmpty)
        XCTAssertEqual(method.returnType.originalType.text, "")
        XCTAssertEqual(method.returnType.resolvedType.text, "")
        XCTAssertEqual(method.declarationText, "func a()")
        XCTAssertFalse(method.throws)
    }

    func test_visit_shouldTransformProtocolMethodParameters() {
        let method = transformMethod("func a(a: A, b c: D, _ e: @escaping F)")
        assertParameter(method.parametersList[0], internalName: "a", type: "A")
        assertParameter(method.parametersList[1], externalName: "b", internalName: "c", type: "D")
        assertParameter(method.parametersList[2], externalName: "_", internalName: "e", type: "F") // TODO: support, isEscaping: true)
        XCTAssertEqual(method.declarationText, "func a(a: A, b c: D, _ e: @escaping F)")
    }

    func test_visit_shouldTransformThrowingProtocolMethod() {
        let method = transformMethod("func a() throws")
        XCTAssert(method.throws)
    }

    func test_visit_shouldTransformReturningProtocolMethod() {
        let method = transformMethod("func a() -> A")
        XCTAssert(method.returnType.originalType is UseCasesTypeIdentifier)
        XCTAssertEqual(method.returnType.originalType.text, "A")
        XCTAssertEqual(method.returnType.resolvedType.text, "A")
    }

    private func transformMethod(_ input: String) -> UseCasesMethod {
        let method = FileParser(fileContents: input).parseFunctionDeclaration()
        let visitor = MethodGatheringVisitor()
        method.accept(visitor)
        return visitor.methods[0]
    }

    private func assertParameter(_ parameter: UseCasesParameter, externalName: String = "", internalName: String, type: String, isEscaping: Bool = false, line: UInt = #line) {
        XCTAssertEqual(parameter.label, externalName)
        XCTAssertEqual(parameter.name, internalName)
        XCTAssertEqual(parameter.type.originalType.text, type)
        XCTAssertEqual(parameter.type.resolvedType.text, type)
        XCTAssertEqual(parameter.isEscaping, isEscaping)
    }

    func test_visit_shouldTransformProtocolProperty() {
        let property = transformProperty("var a: B { get }")
        XCTAssertEqual(property.name, "a")
        XCTAssertEqual(property.type.text, "B")
        XCTAssertFalse(property.isWritable)
    }

    func test_visit_shouldTransformWritableProtocolProperty() {
        let property = transformProperty("var a: B { get set }")
        XCTAssertEqual(property.name, "a")
        XCTAssertEqual(property.type.text, "B")
        XCTAssert(property.isWritable)
        XCTAssertEqual(property.declarationText, "var a: B { get set }")
    }

    func test_visit_shouldTransformComplexTypeProtocolProperty() {
        let property = transformProperty("var a: [B] { get set }")
        XCTAssert(property.type is UseCasesArrayType)
        let array = property.type as! UseCasesArrayType
        XCTAssertEqual(array.text, "[B]")
        XCTAssert(array.type is UseCasesTypeIdentifier)
        XCTAssertEqual(array.type.text, "B")
    }

    private func transformProperty(_ input: String) -> UseCasesProperty {
        let property = FileParser(fileContents: input).parseVariableDeclaration()
        let visitor = MethodGatheringVisitor()
        property.accept(visitor)
        return visitor.properties[0]
    }

    func test_visit_shouldGetAllMethodsFromProtocol() {
        getMethodProtocol().accept(visitor)
        XCTAssertEqual(visitor.methods.count, 3)
    }

    func test_visit_shouldGetAllPropertiesFromProtocol() {
        getPropertyProtocol().accept(visitor)
        XCTAssertEqual(visitor.properties.count, 3)
    }

    // MARK: - Helpers

    private func getMethodProtocol() -> Element {
        let file = FileParser(fileContents: getMethodProtocolString()).parse()
        return file.children[0]
    }

    private func getMethodProtocolString() -> String {
        return """
        protocol TestProtocol {
            func method()
            func method2(label name: Type) -> String
            func method3(label name: Type, param: OtherType) -> String
        }
        """
    }

    private func getPropertyProtocol() -> Element {
        let file = FileParser(fileContents: getPropertyProtocolString()).parse()
        return file.children[0]
    }

    private func getPropertyProtocolString() -> String {
        return """
            protocol TestProtocol {
              var prop1: Int { get set }
              var prop2: String! { get }
              weak var prop3: NSObject? { set get }
            }
        """
    }

    private func getParametersString(_ method: UseCasesMethod) -> String {
        let parameters = method.parametersList
        return parameters.map { $0.text }.joined(separator: ", ")
    }
}
