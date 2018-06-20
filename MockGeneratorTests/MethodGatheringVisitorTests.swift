import XCTest
import SourceKittenFramework
import UseCases
@testable import SwiftStructureInterface
@testable import MockGenerator

class MethodGatheringVisitorTests: XCTestCase {

    var visitor: MethodGatheringVisitor!
    var resolver: Resolver!

    override func setUp() {
        super.setUp()
        resolver = ResolverFactory.createResolver(filePaths: [])
        visitor = MethodGatheringVisitor(resolver: resolver)
    }

    override func tearDown() {
        visitor = nil
        super.tearDown()
    }

    // MARK: - visit
    
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
    }

    func test_shouldTransformFunctionType() {
        let type = transformType("() -> ()", UseCasesFunctionType.self)
        XCTAssertEqual(type.text, "() -> ()")
        XCTAssertFalse(type.throws)
        XCTAssertEqual(type.returnType.text, "()")
        XCTAssertEqual(type.arguments.count, 0)
    }

    func test_shouldTransformThrowingFunctionType() {
        let type = transformType("() throws -> ()", UseCasesFunctionType.self)
        XCTAssertEqual(type.text, "() throws -> ()")
        XCTAssertTrue(type.throws)
    }

    func test_shouldTransformFunctionTypeWithArguments() {
        let type = transformType("(A, [B]) -> ()", UseCasesFunctionType.self)
        XCTAssertEqual(type.text, "(A, [B]) -> ()")
        XCTAssertEqual(type.arguments[0].text, "A")
        XCTAssertEqual(type.arguments[1].text, "[B]")
    }

    func test_shouldTransformTupleType() {
        let type = transformType("(a: A, [B])", UseCasesTupleType.self)
        XCTAssertEqual(type.text, "(a: A, [B])")
        XCTAssertEqual(type.tupleElements[0].label, "a")
        XCTAssertEqual(type.tupleElements[0].text, "a: A")
        XCTAssertNil(type.tupleElements[1].label)
        XCTAssertEqual(type.tupleElements[1].text, "[B]")
    }

    private func assertTypeIs<T: UseCasesType>(_ input: String, _ t: T.Type, _ text: String, line: UInt = #line) {
        let result = transformType(input, T.self)
        XCTAssertEqual(result.text, text, line: line)
    }

    private func transformType<T: UseCasesType>(_ input: String, _ t: T.Type) -> T {
        let type = ElementParser.parseType(input)
        return MethodGatheringVisitor.transformType(type, resolver: resolver) as! T
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
        assertParameter(method.parametersList[2], externalName: "_", internalName: "e", type: "F", isEscaping: true)
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

    func test_visit_shouldTransformGenericParameters() {
        let method = transformMethod("func a<T, U: A, V: B & C>()")
        XCTAssertEqual(method.genericParameters[0], "T")
        XCTAssertEqual(method.genericParameters[1], "U")
        XCTAssertEqual(method.genericParameters[2], "V")
    }

    private func transformMethod(_ input: String) -> UseCasesMethod {
        let method = ElementParser.parseFunctionDeclaration(input)
        method.accept(visitor)
        return visitor.methods[0]
    }

    private func assertParameter(_ parameter: UseCasesParameter, externalName: String? = nil, internalName: String, type: String, isEscaping: Bool = false, line: UInt = #line) {
        XCTAssertEqual(parameter.externalName, externalName, line: line)
        XCTAssertEqual(parameter.internalName, internalName, line: line)
        XCTAssertEqual(parameter.type.originalType.text, type, line: line)
        XCTAssertEqual(parameter.type.resolvedType.text, type, line: line)
        XCTAssertEqual(parameter.isEscaping, isEscaping, line: line)
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
        let property = ElementParser.parseVariableDeclaration(input)
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

    func test_visit_shouldTransformInitializer() {
        getInitializerProtocol().accept(visitor)
        XCTAssertEqual(visitor.initializers.count, 3)
    }

    func test_visit_shouldTransformEmptyInitializer() {
        getInitializerProtocol().accept(visitor)
        let initializer = visitor.initializers[0]
        XCTAssert(initializer.parametersList.isEmpty)
        XCTAssertFalse(initializer.throws)
        XCTAssertFalse(initializer.isFailable)
    }

    func test_visit_shouldTransformThrowingInitializerWithParameters() {
        getInitializerProtocol().accept(visitor)
        let initializer = visitor.initializers[1]
        XCTAssertEqual(initializer.parametersList.count, 1)
        XCTAssertEqual(initializer.parametersList[0].text, "a: A")
        XCTAssert(initializer.throws)
        XCTAssertFalse(initializer.isFailable)
    }

    func test_visit_shouldTransformFailableInitializer() {
        getInitializerProtocol().accept(visitor)
        let initializer = visitor.initializers[2]
        XCTAssertEqual(initializer.parametersList.count, 1)
        XCTAssertEqual(initializer.parametersList[0].text, "b: B")
        XCTAssertFalse(initializer.throws)
        XCTAssert(initializer.isFailable)
    }

    // MARK: - Helpers

    private func getMethodProtocol() -> Element {
        let file = ElementParser.parseFile(getMethodProtocolString())
        return file.typeDeclarations[0]
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
        let file = ElementParser.parseFile(getPropertyProtocolString())
        return file.typeDeclarations[0]
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

    private func getInitializerProtocol() -> Element {
        let file = ElementParser.parseFile(getInitializerProtocolString())
        return file.typeDeclarations[0]
    }

    private func getInitializerProtocolString() -> String {
        return """
            protocol TestProtocol {
              init()
              init(a: A) throws
              init?(b: B)
            }
        """
    }
}
