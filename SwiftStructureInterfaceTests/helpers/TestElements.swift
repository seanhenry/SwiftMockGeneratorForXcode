@testable import SwiftStructureInterface

private let allTypesString = """
public protocol TestProtocol {
  init(a: A)
  var property: String { get }
  func method(paramA: Int)
  func genericMethod<T: U, V: W & X>()
  subscript()
  typealias T = U
  func closure(closure: @escaping () -> ()) -> String
  var type: Base.Nested { get }
  var tuple: (a: A, b: B) { get }
  var array: [A] { get }
  var dict: [A: B] { get }
  var opt: A? { get }
  var protocolComp: A & B { get }
  var generic: A<B> { get }
}
"""

var testFile: File {
    return TestElements.instance.testFile!
}
var testElement: Element {
    return TestElements.instance.testElement!
}
var testTypeDeclaration: TypeDeclaration {
    return TestElements.instance.testTypeDeclaration!
}
var testAccessLevelModifier: AccessLevelModifier {
    return TestElements.instance.testAccessLevelModifier!
}
var testInitializerDeclaration: InitialiserDeclaration {
    return TestElements.instance.testInitializerDeclaration!
}
var testVariableDeclaration: VariableDeclaration {
    return TestElements.instance.testVariableDeclaration!
}
var testType: Type {
    return TestElements.instance.testType!
}
var testTypeIdentifier: TypeIdentifier {
    return TestElements.instance.testTypeIdentifier!
}
var testGenericTypeIdentifier: TypeIdentifier {
    return TestElements.instance.testGenericTypeIdentifier!
}
var testFunctionDeclaration: FunctionDeclaration {
    return TestElements.instance.testFunctionDeclaration!
}
var testParameter: Parameter {
    return TestElements.instance.testParameter!
}
var testGenericParameterClause: GenericParameterClause {
    return TestElements.instance.testGenericParameterClause!
}
var testGenericParameter: GenericParameter {
    return TestElements.instance.testGenericParameter!
}
var testSubscriptDeclaration: SubscriptDeclaration {
    return TestElements.instance.testSubscriptDeclaration!
}
var testTypealias: Typealias {
    return TestElements.instance.testTypealias!
}
var testTypealiasAssignment: TypealiasAssignment {
    return TestElements.instance.testTypealiasAssignment!
}
var testTypeAnnotation: TypeAnnotation {
    return TestElements.instance.testTypeAnnotation!
}
var testTupleType: TupleType {
    return TestElements.instance.testTupleType!
}
var testTupleTypeElement: TupleTypeElement {
    return TestElements.instance.testTupleTypeElement!
}
var testArrayType: ArrayType {
    return TestElements.instance.testArrayType!
}
var testDictionaryType: DictionaryType {
    return TestElements.instance.testDictionaryType!
}
var testOptionalType: OptionalType {
    return TestElements.instance.testOptionalType!
}
var testFunctionType: FunctionType {
    return TestElements.instance.testFunctionType!
}
var testProtocolCompositionType: ProtocolCompositionType {
    return TestElements.instance.testProtocolCompositionType!
}
var testGetterSetterKeywordBlock: GetterSetterKeywordBlock {
    return TestElements.instance.testGetterSetterKeywordBlock!
}

var allTestElements: [Element] {
    return [
        testFile,
        testElement,
        testTypeDeclaration,
        testAccessLevelModifier,
        testInitializerDeclaration,
        testVariableDeclaration,
        testType,
        testTypeIdentifier,
        testFunctionDeclaration,
        testParameter,
        testGenericParameterClause,
        testGenericParameter,
        testSubscriptDeclaration,
        testTypealias,
        testTypealiasAssignment,
        testTypeAnnotation,
        testTupleType,
        testTupleTypeElement,
        testArrayType,
        testDictionaryType,
        testOptionalType,
        testFunctionType,
        testProtocolCompositionType,
        testGetterSetterKeywordBlock
    ]
}

private class TestElements {
    static let instance = TestElements()

    private init() {
        ElementParser.parseFile(allTypesString).accept(Visitor(self))
    }

    private(set) var testFile: File!
    private(set) var testElement: Element!
    private(set) var testTypeDeclaration: TypeDeclaration!
    private(set) var testAccessLevelModifier: AccessLevelModifier!
    private(set) var testInitializerDeclaration: InitialiserDeclaration!
    private(set) var testVariableDeclaration: VariableDeclaration!
    private(set) var testType: Type!
    private(set) var testTypeIdentifier: TypeIdentifier!
    private(set) var testGenericTypeIdentifier: TypeIdentifier!
    private(set) var testFunctionDeclaration: FunctionDeclaration!
    private(set) var testParameter: Parameter!
    private(set) var testGenericParameterClause: GenericParameterClause!
    private(set) var testGenericParameter: GenericParameter!
    private(set) var testSubscriptDeclaration: SubscriptDeclaration!
    private(set) var testTypealias: Typealias!
    private(set) var testTypealiasAssignment: TypealiasAssignment!
    private(set) var testTypeAnnotation: TypeAnnotation!
    private(set) var testTupleType: TupleType!
    private(set) var testTupleTypeElement: TupleTypeElement!
    private(set) var testArrayType: ArrayType!
    private(set) var testDictionaryType: DictionaryType!
    private(set) var testOptionalType: OptionalType!
    private(set) var testFunctionType: FunctionType!
    private(set) var testProtocolCompositionType: ProtocolCompositionType!
    private(set) var testGetterSetterKeywordBlock: GetterSetterKeywordBlock!

    private class Visitor: RecursiveElementVisitor {

        let elements: TestElements

        init(_ elements: TestElements) {
            self.elements = elements
        }

        override func visitElement(_ element: Element) {
            elements.testElement = element
            super.visitElement(element)
        }

        override func visitTypeDeclaration(_ element: TypeDeclaration) {
            elements.testTypeDeclaration = element
            super.visitTypeDeclaration(element)
        }

        override func visitFile(_ element: File) {
            elements.testFile = element
            super.visitFile(element)
        }

        override func visitType(_ element: Type) {
            elements.testType = element
            super.visitType(element)
        }

        override func visitArrayType(_ element: ArrayType) {
            elements.testArrayType = element
            super.visitArrayType(element)
        }

        override func visitDictionaryType(_ element: DictionaryType) {
            elements.testDictionaryType = element
            super.visitDictionaryType(element)
        }

        override func visitOptionalType(_ element: OptionalType) {
            elements.testOptionalType = element
            super.visitOptionalType(element)
        }

        override func visitTypeIdentifier(_ element: TypeIdentifier) {
            if element.text == "Base.Nested" {
                elements.testTypeIdentifier = element
            } else if !element.genericArguments.isEmpty {
                elements.testGenericTypeIdentifier = element
            }
            super.visitTypeIdentifier(element)
        }

        override func visitTupleType(_ element: TupleType) {
            elements.testTupleType = element
            super.visitTupleType(element)
        }

        override func visitTupleTypeElement(_ element: TupleTypeElement) {
            elements.testTupleTypeElement = element
            super.visitTupleTypeElement(element)
        }

        override func visitTypeAnnotation(_ element: TypeAnnotation) {
            elements.testTypeAnnotation = element
            super.visitTypeAnnotation(element)
        }

        override func visitFunctionType(_ element: FunctionType) {
            elements.testFunctionType = element
            super.visitFunctionType(element)
        }

        override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
            elements.testFunctionDeclaration = element
            super.visitFunctionDeclaration(element)
        }

        override func visitVariableDeclaration(_ element: VariableDeclaration) {
            elements.testVariableDeclaration = element
            super.visitVariableDeclaration(element)
        }

        override func visitGenericParameterClause(_ element: GenericParameterClause) {
            if !element.text.isEmpty {
                elements.testGenericParameterClause = element
            }
            super.visitGenericParameterClause(element)
        }

        override func visitGenericParameter(_ element: GenericParameter) {
            if element.typeIdentifier != nil {
                elements.testGenericParameter = element
            }
            super.visitGenericParameter(element)
        }

        override func visitTypealias(_ element: Typealias) {
            elements.testTypealias = element
            super.visitTypealias(element)
        }

        override func visitTypealiasAssignment(_ element: TypealiasAssignment) {
            elements.testTypealiasAssignment = element
            super.visitTypealiasAssignment(element)
        }

        override func visitParameter(_ element: Parameter) {
            elements.testParameter = element
            super.visitParameter(element)
        }

        override func visitInitialiserDeclaration(_ element: InitialiserDeclaration) {
            elements.testInitializerDeclaration = element
            super.visitInitialiserDeclaration(element)
        }

        override func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
            elements.testSubscriptDeclaration = element
            super.visitSubscriptDeclaration(element)
        }

        override func visitAccessLevelModifier(_ element: AccessLevelModifier) {
            elements.testAccessLevelModifier = element
            super.visitAccessLevelModifier(element)
        }

        override func visitProtocolCompositionType(_ element: ProtocolCompositionType) {
            elements.testProtocolCompositionType = element
            super.visitProtocolCompositionType(element)
        }

        override func visitGetterSetterKeywordBlock(_ element: GetterSetterKeywordBlock) {
            elements.testGetterSetterKeywordBlock = element
            super.visitGetterSetterKeywordBlock(element)
        }
    }
}
