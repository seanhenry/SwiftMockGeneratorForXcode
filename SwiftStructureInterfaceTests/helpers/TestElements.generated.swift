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
var testArrayLiteralExpression: ArrayLiteralExpression {
  return TestElements.instance.testArrayLiteralExpression!
}
var testArrayLiteralItem: ArrayLiteralItem {
  return TestElements.instance.testArrayLiteralItem!
}
var testArrayLiteralItems: ArrayLiteralItems {
  return TestElements.instance.testArrayLiteralItems!
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
var testCaptureList: CaptureList {
  return TestElements.instance.testCaptureList!
}
var testCaptureListItem: CaptureListItem {
  return TestElements.instance.testCaptureListItem!
}
var testCaptureListItems: CaptureListItems {
  return TestElements.instance.testCaptureListItems!
}
var testClassDeclaration: ClassDeclaration {
  return TestElements.instance.testClassDeclaration!
}
var testClosureExpression: ClosureExpression {
  return TestElements.instance.testClosureExpression!
}
var testClosureParameter: ClosureParameter {
  return TestElements.instance.testClosureParameter!
}
var testClosureParameterClause: ClosureParameterClause {
  return TestElements.instance.testClosureParameterClause!
}
var testClosureParameterList: ClosureParameterList {
  return TestElements.instance.testClosureParameterList!
}
var testClosureSignature: ClosureSignature {
  return TestElements.instance.testClosureSignature!
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
var testDictionaryLiteralExpression: DictionaryLiteralExpression {
  return TestElements.instance.testDictionaryLiteralExpression!
}
var testDictionaryLiteralItem: DictionaryLiteralItem {
  return TestElements.instance.testDictionaryLiteralItem!
}
var testDictionaryLiteralItems: DictionaryLiteralItems {
  return TestElements.instance.testDictionaryLiteralItems!
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
var testForcedValueExpression: ForcedValueExpression {
  return TestElements.instance.testForcedValueExpression!
}
var testFunctionCallArgument: FunctionCallArgument {
  return TestElements.instance.testFunctionCallArgument!
}
var testFunctionCallArgumentClause: FunctionCallArgumentClause {
  return TestElements.instance.testFunctionCallArgumentClause!
}
var testFunctionCallArgumentList: FunctionCallArgumentList {
  return TestElements.instance.testFunctionCallArgumentList!
}
var testFunctionCallExpression: FunctionCallExpression {
  return TestElements.instance.testFunctionCallExpression!
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
var testIdentifierList: IdentifierList {
  return TestElements.instance.testIdentifierList!
}
var testIdentifierPrimaryExpression: IdentifierPrimaryExpression {
  return TestElements.instance.testIdentifierPrimaryExpression!
}
var testImplicitMemberExpression: ImplicitMemberExpression {
  return TestElements.instance.testImplicitMemberExpression!
}
var testInOutExpression: InOutExpression {
  return TestElements.instance.testInOutExpression!
}
var testInitializerDeclaration: InitializerDeclaration {
  return TestElements.instance.testInitializerDeclaration!
}
var testKeyPathComponent: KeyPathComponent {
  return TestElements.instance.testKeyPathComponent!
}
var testKeyPathComponents: KeyPathComponents {
  return TestElements.instance.testKeyPathComponents!
}
var testKeyPathExpression: KeyPathExpression {
  return TestElements.instance.testKeyPathExpression!
}
var testKeyPathPostfix: KeyPathPostfix {
  return TestElements.instance.testKeyPathPostfix!
}
var testKeyPathPostfixes: KeyPathPostfixes {
  return TestElements.instance.testKeyPathPostfixes!
}
var testKeyPathStringExpression: KeyPathStringExpression {
  return TestElements.instance.testKeyPathStringExpression!
}
var testKeywordLiteralExpression: KeywordLiteralExpression {
  return TestElements.instance.testKeywordLiteralExpression!
}
var testLeafNode: LeafNode {
  return TestElements.instance.testLeafNode!
}
var testLiteralExpression: LiteralExpression {
  return TestElements.instance.testLiteralExpression!
}
var testMutationModifier: MutationModifier {
  return TestElements.instance.testMutationModifier!
}
var testOperatorPostfixExpression: OperatorPostfixExpression {
  return TestElements.instance.testOperatorPostfixExpression!
}
var testOptionalChainingExpression: OptionalChainingExpression {
  return TestElements.instance.testOptionalChainingExpression!
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
var testParenthesizedExpression: ParenthesizedExpression {
  return TestElements.instance.testParenthesizedExpression!
}
var testPlaygroundLiteralArgument: PlaygroundLiteralArgument {
  return TestElements.instance.testPlaygroundLiteralArgument!
}
var testPlaygroundLiteralArguments: PlaygroundLiteralArguments {
  return TestElements.instance.testPlaygroundLiteralArguments!
}
var testPlaygroundLiteralExpression: PlaygroundLiteralExpression {
  return TestElements.instance.testPlaygroundLiteralExpression!
}
var testPostfixExpression: PostfixExpression {
  return TestElements.instance.testPostfixExpression!
}
var testPostfixSelfExpression: PostfixSelfExpression {
  return TestElements.instance.testPostfixSelfExpression!
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
var testSelectorExpression: SelectorExpression {
  return TestElements.instance.testSelectorExpression!
}
var testSelfExpression: SelfExpression {
  return TestElements.instance.testSelfExpression!
}
var testSelfInitializerExpression: SelfInitializerExpression {
  return TestElements.instance.testSelfInitializerExpression!
}
var testSelfMethodExpression: SelfMethodExpression {
  return TestElements.instance.testSelfMethodExpression!
}
var testSelfSubscriptExpression: SelfSubscriptExpression {
  return TestElements.instance.testSelfSubscriptExpression!
}
var testSubscriptDeclaration: SubscriptDeclaration {
  return TestElements.instance.testSubscriptDeclaration!
}
var testSuperclassExpression: SuperclassExpression {
  return TestElements.instance.testSuperclassExpression!
}
var testSuperclassInitializerExpression: SuperclassInitializerExpression {
  return TestElements.instance.testSuperclassInitializerExpression!
}
var testSuperclassMethodExpression: SuperclassMethodExpression {
  return TestElements.instance.testSuperclassMethodExpression!
}
var testSuperclassSubscriptExpression: SuperclassSubscriptExpression {
  return TestElements.instance.testSuperclassSubscriptExpression!
}
var testTupleElement: TupleElement {
  return TestElements.instance.testTupleElement!
}
var testTupleElementList: TupleElementList {
  return TestElements.instance.testTupleElementList!
}
var testTupleExpression: TupleExpression {
  return TestElements.instance.testTupleExpression!
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
var testWildcardExpression: WildcardExpression {
  return TestElements.instance.testWildcardExpression!
}
var allTestElements: [Element] {
  return [
    testAccessLevelModifier,
    testArrayLiteralExpression,
    testArrayLiteralItem,
    testArrayLiteralItems,
    testArrayType,
    testAssociatedTypeDeclaration,
    testAttribute,
    testAttributes,
    testCaptureList,
    testCaptureListItem,
    testCaptureListItems,
    testClassDeclaration,
    testClosureExpression,
    testClosureParameter,
    testClosureParameterClause,
    testClosureParameterList,
    testClosureSignature,
    testCodeBlock,
    testConformanceRequirement,
    testDeclaration,
    testDeclarationModifier,
    testDictionaryLiteralExpression,
    testDictionaryLiteralItem,
    testDictionaryLiteralItems,
    testDictionaryType,
    testElement,
    testExpression,
    testFile,
    testForcedValueExpression,
    testFunctionCallArgument,
    testFunctionCallArgumentClause,
    testFunctionCallArgumentList,
    testFunctionCallExpression,
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
    testIdentifierList,
    testIdentifierPrimaryExpression,
    testImplicitMemberExpression,
    testInOutExpression,
    testInitializerDeclaration,
    testKeyPathComponent,
    testKeyPathComponents,
    testKeyPathExpression,
    testKeyPathPostfix,
    testKeyPathPostfixes,
    testKeyPathStringExpression,
    testKeywordLiteralExpression,
    testLeafNode,
    testLiteralExpression,
    testMutationModifier,
    testOperatorPostfixExpression,
    testOptionalChainingExpression,
    testOptionalType,
    testParameter,
    testParameterClause,
    testParenthesizedExpression,
    testPlaygroundLiteralArgument,
    testPlaygroundLiteralArguments,
    testPlaygroundLiteralExpression,
    testPostfixExpression,
    testPostfixSelfExpression,
    testPrefixExpression,
    testPrimaryExpression,
    testProtocolCompositionType,
    testProtocolDeclaration,
    testRequirement,
    testRequirementList,
    testSameTypeRequirement,
    testSelectorExpression,
    testSelfExpression,
    testSelfInitializerExpression,
    testSelfMethodExpression,
    testSelfSubscriptExpression,
    testSubscriptDeclaration,
    testSuperclassExpression,
    testSuperclassInitializerExpression,
    testSuperclassMethodExpression,
    testSuperclassSubscriptExpression,
    testTupleElement,
    testTupleElementList,
    testTupleExpression,
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
    testWildcardExpression,
  ]
}

private class TestElements {
  static let instance = TestElements()

  private init() {
    try! ElementParser.parseFile(allTypesString).accept(Visitor(self))
  }
  private(set) var testAccessLevelModifier: AccessLevelModifier!
  private(set) var testArrayLiteralExpression: ArrayLiteralExpression!
  private(set) var testArrayLiteralItem: ArrayLiteralItem!
  private(set) var testArrayLiteralItems: ArrayLiteralItems!
  private(set) var testArrayType: ArrayType!
  private(set) var testAssociatedTypeDeclaration: AssociatedTypeDeclaration!
  private(set) var testAttribute: Attribute!
  private(set) var testAttributes: Attributes!
  private(set) var testCaptureList: CaptureList!
  private(set) var testCaptureListItem: CaptureListItem!
  private(set) var testCaptureListItems: CaptureListItems!
  private(set) var testClassDeclaration: ClassDeclaration!
  private(set) var testClosureExpression: ClosureExpression!
  private(set) var testClosureParameter: ClosureParameter!
  private(set) var testClosureParameterClause: ClosureParameterClause!
  private(set) var testClosureParameterList: ClosureParameterList!
  private(set) var testClosureSignature: ClosureSignature!
  private(set) var testCodeBlock: CodeBlock!
  private(set) var testConformanceRequirement: ConformanceRequirement!
  private(set) var testDeclaration: Declaration!
  private(set) var testDeclarationModifier: DeclarationModifier!
  private(set) var testDictionaryLiteralExpression: DictionaryLiteralExpression!
  private(set) var testDictionaryLiteralItem: DictionaryLiteralItem!
  private(set) var testDictionaryLiteralItems: DictionaryLiteralItems!
  private(set) var testDictionaryType: DictionaryType!
  private(set) var testElement: Element!
  private(set) var testExpression: Expression!
  private(set) var testFile: File!
  private(set) var testForcedValueExpression: ForcedValueExpression!
  private(set) var testFunctionCallArgument: FunctionCallArgument!
  private(set) var testFunctionCallArgumentClause: FunctionCallArgumentClause!
  private(set) var testFunctionCallArgumentList: FunctionCallArgumentList!
  private(set) var testFunctionCallExpression: FunctionCallExpression!
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
  private(set) var testIdentifierList: IdentifierList!
  private(set) var testIdentifierPrimaryExpression: IdentifierPrimaryExpression!
  private(set) var testImplicitMemberExpression: ImplicitMemberExpression!
  private(set) var testInOutExpression: InOutExpression!
  private(set) var testInitializerDeclaration: InitializerDeclaration!
  private(set) var testKeyPathComponent: KeyPathComponent!
  private(set) var testKeyPathComponents: KeyPathComponents!
  private(set) var testKeyPathExpression: KeyPathExpression!
  private(set) var testKeyPathPostfix: KeyPathPostfix!
  private(set) var testKeyPathPostfixes: KeyPathPostfixes!
  private(set) var testKeyPathStringExpression: KeyPathStringExpression!
  private(set) var testKeywordLiteralExpression: KeywordLiteralExpression!
  private(set) var testLeafNode: LeafNode!
  private(set) var testLiteralExpression: LiteralExpression!
  private(set) var testMutationModifier: MutationModifier!
  private(set) var testOperatorPostfixExpression: OperatorPostfixExpression!
  private(set) var testOptionalChainingExpression: OptionalChainingExpression!
  private(set) var testOptionalType: OptionalType!
  private(set) var testParameter: Parameter!
  private(set) var testParameterClause: ParameterClause!
  private(set) var testParenthesizedExpression: ParenthesizedExpression!
  private(set) var testPlaygroundLiteralArgument: PlaygroundLiteralArgument!
  private(set) var testPlaygroundLiteralArguments: PlaygroundLiteralArguments!
  private(set) var testPlaygroundLiteralExpression: PlaygroundLiteralExpression!
  private(set) var testPostfixExpression: PostfixExpression!
  private(set) var testPostfixSelfExpression: PostfixSelfExpression!
  private(set) var testPrefixExpression: PrefixExpression!
  private(set) var testPrimaryExpression: PrimaryExpression!
  private(set) var testProtocolCompositionType: ProtocolCompositionType!
  private(set) var testProtocolDeclaration: ProtocolDeclaration!
  private(set) var testRequirement: Requirement!
  private(set) var testRequirementList: RequirementList!
  private(set) var testSameTypeRequirement: SameTypeRequirement!
  private(set) var testSelectorExpression: SelectorExpression!
  private(set) var testSelfExpression: SelfExpression!
  private(set) var testSelfInitializerExpression: SelfInitializerExpression!
  private(set) var testSelfMethodExpression: SelfMethodExpression!
  private(set) var testSelfSubscriptExpression: SelfSubscriptExpression!
  private(set) var testSubscriptDeclaration: SubscriptDeclaration!
  private(set) var testSuperclassExpression: SuperclassExpression!
  private(set) var testSuperclassInitializerExpression: SuperclassInitializerExpression!
  private(set) var testSuperclassMethodExpression: SuperclassMethodExpression!
  private(set) var testSuperclassSubscriptExpression: SuperclassSubscriptExpression!
  private(set) var testTupleElement: TupleElement!
  private(set) var testTupleElementList: TupleElementList!
  private(set) var testTupleExpression: TupleExpression!
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
  private(set) var testWildcardExpression: WildcardExpression!

  private class Visitor: RecursiveElementVisitor {

    let elements: TestElements

    init(_ elements: TestElements) {
      self.elements = elements
    }

    override func visitAccessLevelModifier(_ element: AccessLevelModifier) {
      elements.testAccessLevelModifier = element
      super.visitAccessLevelModifier(element)
    }

    override func visitArrayLiteralExpression(_ element: ArrayLiteralExpression) {
      elements.testArrayLiteralExpression = element
      super.visitArrayLiteralExpression(element)
    }

    override func visitArrayLiteralItem(_ element: ArrayLiteralItem) {
      elements.testArrayLiteralItem = element
      super.visitArrayLiteralItem(element)
    }

    override func visitArrayLiteralItems(_ element: ArrayLiteralItems) {
      elements.testArrayLiteralItems = element
      super.visitArrayLiteralItems(element)
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

    override func visitCaptureList(_ element: CaptureList) {
      elements.testCaptureList = element
      super.visitCaptureList(element)
    }

    override func visitCaptureListItem(_ element: CaptureListItem) {
      elements.testCaptureListItem = element
      super.visitCaptureListItem(element)
    }

    override func visitCaptureListItems(_ element: CaptureListItems) {
      elements.testCaptureListItems = element
      super.visitCaptureListItems(element)
    }

    override func visitClassDeclaration(_ element: ClassDeclaration) {
      elements.testClassDeclaration = element
      super.visitClassDeclaration(element)
    }

    override func visitClosureExpression(_ element: ClosureExpression) {
      elements.testClosureExpression = element
      super.visitClosureExpression(element)
    }

    override func visitClosureParameter(_ element: ClosureParameter) {
      elements.testClosureParameter = element
      super.visitClosureParameter(element)
    }

    override func visitClosureParameterClause(_ element: ClosureParameterClause) {
      elements.testClosureParameterClause = element
      super.visitClosureParameterClause(element)
    }

    override func visitClosureParameterList(_ element: ClosureParameterList) {
      elements.testClosureParameterList = element
      super.visitClosureParameterList(element)
    }

    override func visitClosureSignature(_ element: ClosureSignature) {
      elements.testClosureSignature = element
      super.visitClosureSignature(element)
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

    override func visitDictionaryLiteralExpression(_ element: DictionaryLiteralExpression) {
      elements.testDictionaryLiteralExpression = element
      super.visitDictionaryLiteralExpression(element)
    }

    override func visitDictionaryLiteralItem(_ element: DictionaryLiteralItem) {
      elements.testDictionaryLiteralItem = element
      super.visitDictionaryLiteralItem(element)
    }

    override func visitDictionaryLiteralItems(_ element: DictionaryLiteralItems) {
      elements.testDictionaryLiteralItems = element
      super.visitDictionaryLiteralItems(element)
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

    override func visitForcedValueExpression(_ element: ForcedValueExpression) {
      elements.testForcedValueExpression = element
      super.visitForcedValueExpression(element)
    }

    override func visitFunctionCallArgument(_ element: FunctionCallArgument) {
      elements.testFunctionCallArgument = element
      super.visitFunctionCallArgument(element)
    }

    override func visitFunctionCallArgumentClause(_ element: FunctionCallArgumentClause) {
      elements.testFunctionCallArgumentClause = element
      super.visitFunctionCallArgumentClause(element)
    }

    override func visitFunctionCallArgumentList(_ element: FunctionCallArgumentList) {
      elements.testFunctionCallArgumentList = element
      super.visitFunctionCallArgumentList(element)
    }

    override func visitFunctionCallExpression(_ element: FunctionCallExpression) {
      elements.testFunctionCallExpression = element
      super.visitFunctionCallExpression(element)
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

    override func visitIdentifierList(_ element: IdentifierList) {
      elements.testIdentifierList = element
      super.visitIdentifierList(element)
    }

    override func visitIdentifierPrimaryExpression(_ element: IdentifierPrimaryExpression) {
      elements.testIdentifierPrimaryExpression = element
      super.visitIdentifierPrimaryExpression(element)
    }

    override func visitImplicitMemberExpression(_ element: ImplicitMemberExpression) {
      elements.testImplicitMemberExpression = element
      super.visitImplicitMemberExpression(element)
    }

    override func visitInOutExpression(_ element: InOutExpression) {
      elements.testInOutExpression = element
      super.visitInOutExpression(element)
    }

    override func visitInitializerDeclaration(_ element: InitializerDeclaration) {
      elements.testInitializerDeclaration = element
      super.visitInitializerDeclaration(element)
    }

    override func visitKeyPathComponent(_ element: KeyPathComponent) {
      elements.testKeyPathComponent = element
      super.visitKeyPathComponent(element)
    }

    override func visitKeyPathComponents(_ element: KeyPathComponents) {
      elements.testKeyPathComponents = element
      super.visitKeyPathComponents(element)
    }

    override func visitKeyPathExpression(_ element: KeyPathExpression) {
      elements.testKeyPathExpression = element
      super.visitKeyPathExpression(element)
    }

    override func visitKeyPathPostfix(_ element: KeyPathPostfix) {
      elements.testKeyPathPostfix = element
      super.visitKeyPathPostfix(element)
    }

    override func visitKeyPathPostfixes(_ element: KeyPathPostfixes) {
      elements.testKeyPathPostfixes = element
      super.visitKeyPathPostfixes(element)
    }

    override func visitKeyPathStringExpression(_ element: KeyPathStringExpression) {
      elements.testKeyPathStringExpression = element
      super.visitKeyPathStringExpression(element)
    }

    override func visitKeywordLiteralExpression(_ element: KeywordLiteralExpression) {
      elements.testKeywordLiteralExpression = element
      super.visitKeywordLiteralExpression(element)
    }

    override func visitLeafNode(_ element: LeafNode) {
      elements.testLeafNode = element
      super.visitLeafNode(element)
    }

    override func visitLiteralExpression(_ element: LiteralExpression) {
      elements.testLiteralExpression = element
      super.visitLiteralExpression(element)
    }

    override func visitMutationModifier(_ element: MutationModifier) {
      elements.testMutationModifier = element
      super.visitMutationModifier(element)
    }

    override func visitOperatorPostfixExpression(_ element: OperatorPostfixExpression) {
      elements.testOperatorPostfixExpression = element
      super.visitOperatorPostfixExpression(element)
    }

    override func visitOptionalChainingExpression(_ element: OptionalChainingExpression) {
      elements.testOptionalChainingExpression = element
      super.visitOptionalChainingExpression(element)
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

    override func visitParenthesizedExpression(_ element: ParenthesizedExpression) {
      elements.testParenthesizedExpression = element
      super.visitParenthesizedExpression(element)
    }

    override func visitPlaygroundLiteralArgument(_ element: PlaygroundLiteralArgument) {
      elements.testPlaygroundLiteralArgument = element
      super.visitPlaygroundLiteralArgument(element)
    }

    override func visitPlaygroundLiteralArguments(_ element: PlaygroundLiteralArguments) {
      elements.testPlaygroundLiteralArguments = element
      super.visitPlaygroundLiteralArguments(element)
    }

    override func visitPlaygroundLiteralExpression(_ element: PlaygroundLiteralExpression) {
      elements.testPlaygroundLiteralExpression = element
      super.visitPlaygroundLiteralExpression(element)
    }

    override func visitPostfixExpression(_ element: PostfixExpression) {
      elements.testPostfixExpression = element
      super.visitPostfixExpression(element)
    }

    override func visitPostfixSelfExpression(_ element: PostfixSelfExpression) {
      elements.testPostfixSelfExpression = element
      super.visitPostfixSelfExpression(element)
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

    override func visitSelectorExpression(_ element: SelectorExpression) {
      elements.testSelectorExpression = element
      super.visitSelectorExpression(element)
    }

    override func visitSelfExpression(_ element: SelfExpression) {
      elements.testSelfExpression = element
      super.visitSelfExpression(element)
    }

    override func visitSelfInitializerExpression(_ element: SelfInitializerExpression) {
      elements.testSelfInitializerExpression = element
      super.visitSelfInitializerExpression(element)
    }

    override func visitSelfMethodExpression(_ element: SelfMethodExpression) {
      elements.testSelfMethodExpression = element
      super.visitSelfMethodExpression(element)
    }

    override func visitSelfSubscriptExpression(_ element: SelfSubscriptExpression) {
      elements.testSelfSubscriptExpression = element
      super.visitSelfSubscriptExpression(element)
    }

    override func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
      elements.testSubscriptDeclaration = element
      super.visitSubscriptDeclaration(element)
    }

    override func visitSuperclassExpression(_ element: SuperclassExpression) {
      elements.testSuperclassExpression = element
      super.visitSuperclassExpression(element)
    }

    override func visitSuperclassInitializerExpression(_ element: SuperclassInitializerExpression) {
      elements.testSuperclassInitializerExpression = element
      super.visitSuperclassInitializerExpression(element)
    }

    override func visitSuperclassMethodExpression(_ element: SuperclassMethodExpression) {
      elements.testSuperclassMethodExpression = element
      super.visitSuperclassMethodExpression(element)
    }

    override func visitSuperclassSubscriptExpression(_ element: SuperclassSubscriptExpression) {
      elements.testSuperclassSubscriptExpression = element
      super.visitSuperclassSubscriptExpression(element)
    }

    override func visitTupleElement(_ element: TupleElement) {
      elements.testTupleElement = element
      super.visitTupleElement(element)
    }

    override func visitTupleElementList(_ element: TupleElementList) {
      elements.testTupleElementList = element
      super.visitTupleElementList(element)
    }

    override func visitTupleExpression(_ element: TupleExpression) {
      elements.testTupleExpression = element
      super.visitTupleExpression(element)
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

    override func visitWildcardExpression(_ element: WildcardExpression) {
      elements.testWildcardExpression = element
      super.visitWildcardExpression(element)
    }
  }
}
