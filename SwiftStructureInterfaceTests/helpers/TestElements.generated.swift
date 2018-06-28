// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import SwiftStructureInterface

private let allTypesString = """
class TestClass {}

public protocol TestProtocol: Z where A: B, C == D {
  init(a: A)
  var property: String { get }
  func method(paramA: Int)
  func genericMethod<T: U, V: W & X>()
  subscript()
  typealias T = U
  associatedtype T = U
  mutating func closure(closure: @escaping () -> ()) -> String
  var type: Base.Nested { get }
  var tuple: (a: A, b: B) { get }
  var array: [A] { get }
  var dict: [A: B] { get }
  var opt: A? { get }
  var protocolComp: A & B { get }
  var generic: A<B> { get }
}
"""
var testAccessLevelModifier: AccessLevelModifier {
  return TestElements.instance.testAccessLevelModifier!
}
var testArrayType: ArrayType {
  return TestElements.instance.testArrayType!
}
var testAssociatedTypeDeclaration: AssociatedTypeDeclaration {
  return TestElements.instance.testAssociatedTypeDeclaration!
}
var testAttribute: Attribute {
  return TestElements.instance.testAttribute!
}
var testAttributes: Attributes {
  return TestElements.instance.testAttributes!
}
var testClassDeclaration: ClassDeclaration {
  return TestElements.instance.testClassDeclaration!
}
var testCodeBlock: CodeBlock {
  return TestElements.instance.testCodeBlock!
}
var testConformanceRequirement: ConformanceRequirement {
  return TestElements.instance.testConformanceRequirement!
}
var testDeclaration: Declaration {
  return TestElements.instance.testDeclaration!
}
var testDeclarationModifier: DeclarationModifier {
  return TestElements.instance.testDeclarationModifier!
}
var testDictionaryType: DictionaryType {
  return TestElements.instance.testDictionaryType!
}
var testElement: Element {
  return TestElements.instance.testElement!
}
var testExpression: Expression {
  return TestElements.instance.testExpression!
}
var testFile: File {
  return TestElements.instance.testFile!
}
var testFunctionDeclaration: FunctionDeclaration {
  return TestElements.instance.testFunctionDeclaration!
}
var testFunctionResult: FunctionResult {
  return TestElements.instance.testFunctionResult!
}
var testFunctionType: FunctionType {
  return TestElements.instance.testFunctionType!
}
var testGenericArgumentClause: GenericArgumentClause {
  return TestElements.instance.testGenericArgumentClause!
}
var testGenericParameter: GenericParameter {
  return TestElements.instance.testGenericParameter!
}
var testGenericParameterClause: GenericParameterClause {
  return TestElements.instance.testGenericParameterClause!
}
var testGenericWhereClause: GenericWhereClause {
  return TestElements.instance.testGenericWhereClause!
}
var testGetterSetterKeywordBlock: GetterSetterKeywordBlock {
  return TestElements.instance.testGetterSetterKeywordBlock!
}
var testGetterSetterKeywordClause: GetterSetterKeywordClause {
  return TestElements.instance.testGetterSetterKeywordClause!
}
var testIdentifier: Identifier {
  return TestElements.instance.testIdentifier!
}
var testIdentifierPrimaryExpression: IdentifierPrimaryExpression {
  return TestElements.instance.testIdentifierPrimaryExpression!
}
var testInOutExpression: InOutExpression {
  return TestElements.instance.testInOutExpression!
}
var testInitializerDeclaration: InitializerDeclaration {
  return TestElements.instance.testInitializerDeclaration!
}
var testLeafNode: LeafNode {
  return TestElements.instance.testLeafNode!
}
var testMutationModifier: MutationModifier {
  return TestElements.instance.testMutationModifier!
}
var testOptionalType: OptionalType {
  return TestElements.instance.testOptionalType!
}
var testParameter: Parameter {
  return TestElements.instance.testParameter!
}
var testParameterClause: ParameterClause {
  return TestElements.instance.testParameterClause!
}
var testPrefixExpression: PrefixExpression {
  return TestElements.instance.testPrefixExpression!
}
var testPrimaryExpression: PrimaryExpression {
  return TestElements.instance.testPrimaryExpression!
}
var testProtocolCompositionType: ProtocolCompositionType {
  return TestElements.instance.testProtocolCompositionType!
}
var testProtocolDeclaration: ProtocolDeclaration {
  return TestElements.instance.testProtocolDeclaration!
}
var testRequirement: Requirement {
  return TestElements.instance.testRequirement!
}
var testRequirementList: RequirementList {
  return TestElements.instance.testRequirementList!
}
var testSameTypeRequirement: SameTypeRequirement {
  return TestElements.instance.testSameTypeRequirement!
}
var testSubscriptDeclaration: SubscriptDeclaration {
  return TestElements.instance.testSubscriptDeclaration!
}
var testTupleType: TupleType {
  return TestElements.instance.testTupleType!
}
var testTupleTypeElement: TupleTypeElement {
  return TestElements.instance.testTupleTypeElement!
}
var testTupleTypeElementList: TupleTypeElementList {
  return TestElements.instance.testTupleTypeElementList!
}
var testType: Type {
  return TestElements.instance.testType!
}
var testTypeAnnotation: TypeAnnotation {
  return TestElements.instance.testTypeAnnotation!
}
var testTypeDeclaration: TypeDeclaration {
  return TestElements.instance.testTypeDeclaration!
}
var testTypeIdentifier: TypeIdentifier {
  return TestElements.instance.testTypeIdentifier!
}
var testTypeInheritanceClause: TypeInheritanceClause {
  return TestElements.instance.testTypeInheritanceClause!
}
var testTypealiasAssignment: TypealiasAssignment {
  return TestElements.instance.testTypealiasAssignment!
}
var testTypealiasDeclaration: TypealiasDeclaration {
  return TestElements.instance.testTypealiasDeclaration!
}
var testVariableDeclaration: VariableDeclaration {
  return TestElements.instance.testVariableDeclaration!
}
var testWhitespace: Whitespace {
  return TestElements.instance.testWhitespace!
}
var allTestElements: [Element] {
  return [
    testAccessLevelModifier,
    testArrayType,
    testAssociatedTypeDeclaration,
    testAttribute,
    testAttributes,
    testClassDeclaration,
    testCodeBlock,
    testConformanceRequirement,
    testDeclaration,
    testDeclarationModifier,
    testDictionaryType,
    testElement,
    testExpression,
    testFile,
    testFunctionDeclaration,
    testFunctionResult,
    testFunctionType,
    testGenericArgumentClause,
    testGenericParameter,
    testGenericParameterClause,
    testGenericWhereClause,
    testGetterSetterKeywordBlock,
    testGetterSetterKeywordClause,
    testIdentifier,
    testIdentifierPrimaryExpression,
    testInOutExpression,
    testInitializerDeclaration,
    testLeafNode,
    testMutationModifier,
    testOptionalType,
    testParameter,
    testParameterClause,
    testPrefixExpression,
    testPrimaryExpression,
    testProtocolCompositionType,
    testProtocolDeclaration,
    testRequirement,
    testRequirementList,
    testSameTypeRequirement,
    testSubscriptDeclaration,
    testTupleType,
    testTupleTypeElement,
    testTupleTypeElementList,
    testType,
    testTypeAnnotation,
    testTypeDeclaration,
    testTypeIdentifier,
    testTypeInheritanceClause,
    testTypealiasAssignment,
    testTypealiasDeclaration,
    testVariableDeclaration,
    testWhitespace,
  ]
}

private class TestElements {
  static let instance = TestElements()

  private init() {
    try! ElementParser.parseFile(allTypesString).accept(Visitor(self))
  }
  private(set) var testAccessLevelModifier: AccessLevelModifier!
  private(set) var testArrayType: ArrayType!
  private(set) var testAssociatedTypeDeclaration: AssociatedTypeDeclaration!
  private(set) var testAttribute: Attribute!
  private(set) var testAttributes: Attributes!
  private(set) var testClassDeclaration: ClassDeclaration!
  private(set) var testCodeBlock: CodeBlock!
  private(set) var testConformanceRequirement: ConformanceRequirement!
  private(set) var testDeclaration: Declaration!
  private(set) var testDeclarationModifier: DeclarationModifier!
  private(set) var testDictionaryType: DictionaryType!
  private(set) var testElement: Element!
  private(set) var testExpression: Expression!
  private(set) var testFile: File!
  private(set) var testFunctionDeclaration: FunctionDeclaration!
  private(set) var testFunctionResult: FunctionResult!
  private(set) var testFunctionType: FunctionType!
  private(set) var testGenericArgumentClause: GenericArgumentClause!
  private(set) var testGenericParameter: GenericParameter!
  private(set) var testGenericParameterClause: GenericParameterClause!
  private(set) var testGenericWhereClause: GenericWhereClause!
  private(set) var testGetterSetterKeywordBlock: GetterSetterKeywordBlock!
  private(set) var testGetterSetterKeywordClause: GetterSetterKeywordClause!
  private(set) var testIdentifier: Identifier!
  private(set) var testIdentifierPrimaryExpression: IdentifierPrimaryExpression!
  private(set) var testInOutExpression: InOutExpression!
  private(set) var testInitializerDeclaration: InitializerDeclaration!
  private(set) var testLeafNode: LeafNode!
  private(set) var testMutationModifier: MutationModifier!
  private(set) var testOptionalType: OptionalType!
  private(set) var testParameter: Parameter!
  private(set) var testParameterClause: ParameterClause!
  private(set) var testPrefixExpression: PrefixExpression!
  private(set) var testPrimaryExpression: PrimaryExpression!
  private(set) var testProtocolCompositionType: ProtocolCompositionType!
  private(set) var testProtocolDeclaration: ProtocolDeclaration!
  private(set) var testRequirement: Requirement!
  private(set) var testRequirementList: RequirementList!
  private(set) var testSameTypeRequirement: SameTypeRequirement!
  private(set) var testSubscriptDeclaration: SubscriptDeclaration!
  private(set) var testTupleType: TupleType!
  private(set) var testTupleTypeElement: TupleTypeElement!
  private(set) var testTupleTypeElementList: TupleTypeElementList!
  private(set) var testType: Type!
  private(set) var testTypeAnnotation: TypeAnnotation!
  private(set) var testTypeDeclaration: TypeDeclaration!
  private(set) var testTypeIdentifier: TypeIdentifier!
  private(set) var testTypeInheritanceClause: TypeInheritanceClause!
  private(set) var testTypealiasAssignment: TypealiasAssignment!
  private(set) var testTypealiasDeclaration: TypealiasDeclaration!
  private(set) var testVariableDeclaration: VariableDeclaration!
  private(set) var testWhitespace: Whitespace!

  private class Visitor: RecursiveElementVisitor {

    let elements: TestElements

    init(_ elements: TestElements) {
      self.elements = elements
    }

    override func visitAccessLevelModifier(_ element: AccessLevelModifier) {
      elements.testAccessLevelModifier = element
      super.visitAccessLevelModifier(element)
    }

    override func visitArrayType(_ element: ArrayType) {
      elements.testArrayType = element
      super.visitArrayType(element)
    }

    override func visitAssociatedTypeDeclaration(_ element: AssociatedTypeDeclaration) {
      elements.testAssociatedTypeDeclaration = element
      super.visitAssociatedTypeDeclaration(element)
    }

    override func visitAttribute(_ element: Attribute) {
      elements.testAttribute = element
      super.visitAttribute(element)
    }

    override func visitAttributes(_ element: Attributes) {
      elements.testAttributes = element
      super.visitAttributes(element)
    }

    override func visitClassDeclaration(_ element: ClassDeclaration) {
      elements.testClassDeclaration = element
      super.visitClassDeclaration(element)
    }

    override func visitCodeBlock(_ element: CodeBlock) {
      elements.testCodeBlock = element
      super.visitCodeBlock(element)
    }

    override func visitConformanceRequirement(_ element: ConformanceRequirement) {
      elements.testConformanceRequirement = element
      super.visitConformanceRequirement(element)
    }

    override func visitDeclaration(_ element: Declaration) {
      elements.testDeclaration = element
      super.visitDeclaration(element)
    }

    override func visitDeclarationModifier(_ element: DeclarationModifier) {
      elements.testDeclarationModifier = element
      super.visitDeclarationModifier(element)
    }

    override func visitDictionaryType(_ element: DictionaryType) {
      elements.testDictionaryType = element
      super.visitDictionaryType(element)
    }

    override func visitElement(_ element: Element) {
      elements.testElement = element
      super.visitElement(element)
    }

    override func visitExpression(_ element: Expression) {
      elements.testExpression = element
      super.visitExpression(element)
    }

    override func visitFile(_ element: File) {
      elements.testFile = element
      super.visitFile(element)
    }

    override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
      elements.testFunctionDeclaration = element
      super.visitFunctionDeclaration(element)
    }

    override func visitFunctionResult(_ element: FunctionResult) {
      elements.testFunctionResult = element
      super.visitFunctionResult(element)
    }

    override func visitFunctionType(_ element: FunctionType) {
      elements.testFunctionType = element
      super.visitFunctionType(element)
    }

    override func visitGenericArgumentClause(_ element: GenericArgumentClause) {
      elements.testGenericArgumentClause = element
      super.visitGenericArgumentClause(element)
    }

    override func visitGenericParameter(_ element: GenericParameter) {
      elements.testGenericParameter = element
      super.visitGenericParameter(element)
    }

    override func visitGenericParameterClause(_ element: GenericParameterClause) {
      elements.testGenericParameterClause = element
      super.visitGenericParameterClause(element)
    }

    override func visitGenericWhereClause(_ element: GenericWhereClause) {
      elements.testGenericWhereClause = element
      super.visitGenericWhereClause(element)
    }

    override func visitGetterSetterKeywordBlock(_ element: GetterSetterKeywordBlock) {
      elements.testGetterSetterKeywordBlock = element
      super.visitGetterSetterKeywordBlock(element)
    }

    override func visitGetterSetterKeywordClause(_ element: GetterSetterKeywordClause) {
      elements.testGetterSetterKeywordClause = element
      super.visitGetterSetterKeywordClause(element)
    }

    override func visitIdentifier(_ element: Identifier) {
      elements.testIdentifier = element
      super.visitIdentifier(element)
    }

    override func visitIdentifierPrimaryExpression(_ element: IdentifierPrimaryExpression) {
      elements.testIdentifierPrimaryExpression = element
      super.visitIdentifierPrimaryExpression(element)
    }

    override func visitInOutExpression(_ element: InOutExpression) {
      elements.testInOutExpression = element
      super.visitInOutExpression(element)
    }

    override func visitInitializerDeclaration(_ element: InitializerDeclaration) {
      elements.testInitializerDeclaration = element
      super.visitInitializerDeclaration(element)
    }

    override func visitLeafNode(_ element: LeafNode) {
      elements.testLeafNode = element
      super.visitLeafNode(element)
    }

    override func visitMutationModifier(_ element: MutationModifier) {
      elements.testMutationModifier = element
      super.visitMutationModifier(element)
    }

    override func visitOptionalType(_ element: OptionalType) {
      elements.testOptionalType = element
      super.visitOptionalType(element)
    }

    override func visitParameter(_ element: Parameter) {
      elements.testParameter = element
      super.visitParameter(element)
    }

    override func visitParameterClause(_ element: ParameterClause) {
      elements.testParameterClause = element
      super.visitParameterClause(element)
    }

    override func visitPrefixExpression(_ element: PrefixExpression) {
      elements.testPrefixExpression = element
      super.visitPrefixExpression(element)
    }

    override func visitPrimaryExpression(_ element: PrimaryExpression) {
      elements.testPrimaryExpression = element
      super.visitPrimaryExpression(element)
    }

    override func visitProtocolCompositionType(_ element: ProtocolCompositionType) {
      elements.testProtocolCompositionType = element
      super.visitProtocolCompositionType(element)
    }

    override func visitProtocolDeclaration(_ element: ProtocolDeclaration) {
      elements.testProtocolDeclaration = element
      super.visitProtocolDeclaration(element)
    }

    override func visitRequirement(_ element: Requirement) {
      elements.testRequirement = element
      super.visitRequirement(element)
    }

    override func visitRequirementList(_ element: RequirementList) {
      elements.testRequirementList = element
      super.visitRequirementList(element)
    }

    override func visitSameTypeRequirement(_ element: SameTypeRequirement) {
      elements.testSameTypeRequirement = element
      super.visitSameTypeRequirement(element)
    }

    override func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
      elements.testSubscriptDeclaration = element
      super.visitSubscriptDeclaration(element)
    }

    override func visitTupleType(_ element: TupleType) {
      elements.testTupleType = element
      super.visitTupleType(element)
    }

    override func visitTupleTypeElement(_ element: TupleTypeElement) {
      elements.testTupleTypeElement = element
      super.visitTupleTypeElement(element)
    }

    override func visitTupleTypeElementList(_ element: TupleTypeElementList) {
      elements.testTupleTypeElementList = element
      super.visitTupleTypeElementList(element)
    }

    override func visitType(_ element: Type) {
      elements.testType = element
      super.visitType(element)
    }

    override func visitTypeAnnotation(_ element: TypeAnnotation) {
      elements.testTypeAnnotation = element
      super.visitTypeAnnotation(element)
    }

    override func visitTypeDeclaration(_ element: TypeDeclaration) {
      elements.testTypeDeclaration = element
      super.visitTypeDeclaration(element)
    }

    override func visitTypeIdentifier(_ element: TypeIdentifier) {
      elements.testTypeIdentifier = element
      super.visitTypeIdentifier(element)
    }

    override func visitTypeInheritanceClause(_ element: TypeInheritanceClause) {
      elements.testTypeInheritanceClause = element
      super.visitTypeInheritanceClause(element)
    }

    override func visitTypealiasAssignment(_ element: TypealiasAssignment) {
      elements.testTypealiasAssignment = element
      super.visitTypealiasAssignment(element)
    }

    override func visitTypealiasDeclaration(_ element: TypealiasDeclaration) {
      elements.testTypealiasDeclaration = element
      super.visitTypealiasDeclaration(element)
    }

    override func visitVariableDeclaration(_ element: VariableDeclaration) {
      elements.testVariableDeclaration = element
      super.visitVariableDeclaration(element)
    }

    override func visitWhitespace(_ element: Whitespace) {
      elements.testWhitespace = element
      super.visitWhitespace(element)
    }
  }
}
