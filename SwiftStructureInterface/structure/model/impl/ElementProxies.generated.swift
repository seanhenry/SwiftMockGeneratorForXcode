// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



class AccessLevelModifierProxy: DeclarationModifierProxy, AccessLevelModifier {

  let managedAccessLevelModifier: AccessLevelModifier

  init(_ element: AccessLevelModifier) {
    managedAccessLevelModifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAccessLevelModifier(self)
  }
}

class ArrayTypeProxy: TypeProxy, ArrayType {

  let managedArrayType: ArrayType
  var elementType: Type {
    return proxy(managedArrayType.elementType)

  }

  init(_ element: ArrayType) {
    managedArrayType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayType(self)
  }
}

class AssociatedTypeDeclarationProxy: DeclarationProxy, AssociatedTypeDeclaration {

  let managedAssociatedTypeDeclaration: AssociatedTypeDeclaration
  var typeInheritanceClause: [Element] {
    return managedAssociatedTypeDeclaration.typeInheritanceClause.map(proxy)

  }
  var typealiasAssignment: TypealiasAssignment? {
    return managedAssociatedTypeDeclaration.typealiasAssignment.flatMap(proxy)

  }
  var genericWhereClause: GenericWhereClause? {
    return managedAssociatedTypeDeclaration.genericWhereClause.flatMap(proxy)

  }

  init(_ element: AssociatedTypeDeclaration) {
    managedAssociatedTypeDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAssociatedTypeDeclaration(self)
  }
}

class AttributeProxy: ElementProxy, Attribute {

  let managedAttribute: Attribute

  init(_ element: Attribute) {
    managedAttribute = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttribute(self)
  }
}

class AttributesProxy: ElementProxy, Attributes {

  let managedAttributes: Attributes
  var attributes: [Attribute] {
    return managedAttributes.attributes.map(proxy)

  }

  init(_ element: Attributes) {
    managedAttributes = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttributes(self)
  }
}

class CodeBlockProxy: ElementProxy, CodeBlock {

  let managedCodeBlock: CodeBlock

  init(_ element: CodeBlock) {
    managedCodeBlock = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCodeBlock(self)
  }
}

class ConformanceRequirementProxy: RequirementProxy, ConformanceRequirement {

  let managedConformanceRequirement: ConformanceRequirement
  var rightProtocolCompositionType: ProtocolCompositionType {
    return proxy(managedConformanceRequirement.rightProtocolCompositionType)

  }

  init(_ element: ConformanceRequirement) {
    managedConformanceRequirement = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitConformanceRequirement(self)
  }
}

class DeclarationProxy: ElementProxy, Declaration {

  let managedDeclaration: Declaration
  var attributes: Attributes {
    return proxy(managedDeclaration.attributes)

  }
  var accessLevelModifier: AccessLevelModifier {
    return proxy(managedDeclaration.accessLevelModifier)

  }

  init(_ element: Declaration) {
    managedDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclaration(self)
  }
}

class DeclarationModifierProxy: ElementProxy, DeclarationModifier {

  let managedDeclarationModifier: DeclarationModifier

  init(_ element: DeclarationModifier) {
    managedDeclarationModifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclarationModifier(self)
  }
}

class DictionaryTypeProxy: TypeProxy, DictionaryType {

  let managedDictionaryType: DictionaryType
  var keyType: Type {
    return proxy(managedDictionaryType.keyType)

  }
  var valueType: Type {
    return proxy(managedDictionaryType.valueType)

  }

  init(_ element: DictionaryType) {
    managedDictionaryType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryType(self)
  }
}

class FileProxy: ElementProxy, File {

  let managedFile: File

  init(_ element: File) {
    managedFile = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFile(self)
  }
}

class FunctionDeclarationProxy: ElementProxy, FunctionDeclaration {

  let managedFunctionDeclaration: FunctionDeclaration
  var genericParameterClause: GenericParameterClause? {
    return managedFunctionDeclaration.genericParameterClause.flatMap(proxy)

  }
  var parameterClause: ParameterClause {
    return proxy(managedFunctionDeclaration.parameterClause)

  }
  var returnType: FunctionResult? {
    return managedFunctionDeclaration.returnType.flatMap(proxy)

  }
  var declarations: [Element] {
    return managedFunctionDeclaration.declarations.map(proxy)

  }

  init(_ element: FunctionDeclaration) {
    managedFunctionDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionDeclaration(self)
  }
}

class FunctionResultProxy: ElementProxy, FunctionResult {

  let managedFunctionResult: FunctionResult
  var attributes: Attributes {
    return proxy(managedFunctionResult.attributes)

  }
  var type: Type {
    return proxy(managedFunctionResult.type)

  }

  init(_ element: FunctionResult) {
    managedFunctionResult = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionResult(self)
  }
}

class FunctionTypeProxy: TypeProxy, FunctionType {

  let managedFunctionType: FunctionType
  var attributes: Attributes {
    return proxy(managedFunctionType.attributes)

  }
  var arguments: TupleType {
    return proxy(managedFunctionType.arguments)

  }
  var returnType: Type {
    return proxy(managedFunctionType.returnType)

  }

  init(_ element: FunctionType) {
    managedFunctionType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionType(self)
  }
}

class GenericArgumentClauseProxy: ElementProxy, GenericArgumentClause {

  let managedGenericArgumentClause: GenericArgumentClause
  var arguments: [Type] {
    return managedGenericArgumentClause.arguments.map(proxy)

  }

  init(_ element: GenericArgumentClause) {
    managedGenericArgumentClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericArgumentClause(self)
  }
}

class GenericParameterProxy: ElementProxy, GenericParameter {

  let managedGenericParameter: GenericParameter
  var typeIdentifier: TypeIdentifier? {
    return managedGenericParameter.typeIdentifier.flatMap(proxy)

  }
  var protocolComposition: ProtocolCompositionType? {
    return managedGenericParameter.protocolComposition.flatMap(proxy)

  }

  init(_ element: GenericParameter) {
    managedGenericParameter = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameter(self)
  }
}

class GenericParameterClauseProxy: ElementProxy, GenericParameterClause {

  let managedGenericParameterClause: GenericParameterClause
  var parameters: [GenericParameter] {
    return managedGenericParameterClause.parameters.map(proxy)

  }

  init(_ element: GenericParameterClause) {
    managedGenericParameterClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameterClause(self)
  }
}

class GenericWhereClauseProxy: ElementProxy, GenericWhereClause {

  let managedGenericWhereClause: GenericWhereClause
  var requirementList: RequirementList {
    return proxy(managedGenericWhereClause.requirementList)

  }

  init(_ element: GenericWhereClause) {
    managedGenericWhereClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericWhereClause(self)
  }
}

class GetterSetterKeywordBlockProxy: ElementProxy, GetterSetterKeywordBlock {

  let managedGetterSetterKeywordBlock: GetterSetterKeywordBlock

  init(_ element: GetterSetterKeywordBlock) {
    managedGetterSetterKeywordBlock = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGetterSetterKeywordBlock(self)
  }
}

class GetterSetterKeywordClauseProxy: ElementProxy, GetterSetterKeywordClause {

  let managedGetterSetterKeywordClause: GetterSetterKeywordClause
  var attributes: Attributes {
    return proxy(managedGetterSetterKeywordClause.attributes)

  }
  var mutationModifier: MutationModifier {
    return proxy(managedGetterSetterKeywordClause.mutationModifier)

  }

  init(_ element: GetterSetterKeywordClause) {
    managedGetterSetterKeywordClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGetterSetterKeywordClause(self)
  }
}

class IdentifierProxy: LeafNodeProxy, Identifier {

  let managedIdentifier: Identifier

  init(_ element: Identifier) {
    managedIdentifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifier(self)
  }
}

class InitializerDeclarationProxy: ElementProxy, InitializerDeclaration {

  let managedInitializerDeclaration: InitializerDeclaration
  var parameterClause: ParameterClause {
    return proxy(managedInitializerDeclaration.parameterClause)

  }

  init(_ element: InitializerDeclaration) {
    managedInitializerDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitInitializerDeclaration(self)
  }
}

class LeafNodeProxy: ElementProxy, LeafNode {

  let managedLeafNode: LeafNode
  override var text: String {
    set { managedLeafNode.text = newValue }
    get { return managedLeafNode.text }
  }

  init(_ element: LeafNode) {
    managedLeafNode = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitLeafNode(self)
  }
}

class MutationModifierProxy: DeclarationModifierProxy, MutationModifier {

  let managedMutationModifier: MutationModifier

  init(_ element: MutationModifier) {
    managedMutationModifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitMutationModifier(self)
  }
}

class OptionalTypeProxy: TypeProxy, OptionalType {

  let managedOptionalType: OptionalType
  var type: Type {
    return proxy(managedOptionalType.type)

  }

  init(_ element: OptionalType) {
    managedOptionalType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitOptionalType(self)
  }
}

class ParameterProxy: ElementProxy, Parameter {

  let managedParameter: Parameter
  var typeAnnotation: TypeAnnotation {
    return proxy(managedParameter.typeAnnotation)

  }

  init(_ element: Parameter) {
    managedParameter = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameter(self)
  }
}

class ParameterClauseProxy: ElementProxy, ParameterClause {

  let managedParameterClause: ParameterClause
  var parameters: [Parameter] {
    return managedParameterClause.parameters.map(proxy)

  }

  init(_ element: ParameterClause) {
    managedParameterClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameterClause(self)
  }
}

class ProtocolCompositionTypeProxy: TypeProxy, ProtocolCompositionType {

  let managedProtocolCompositionType: ProtocolCompositionType
  var types: [Type] {
    return managedProtocolCompositionType.types.map(proxy)

  }

  init(_ element: ProtocolCompositionType) {
    managedProtocolCompositionType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitProtocolCompositionType(self)
  }
}

class RequirementProxy: ElementProxy, Requirement {

  let managedRequirement: Requirement
  var leftTypeIdentifier: TypeIdentifier {
    return proxy(managedRequirement.leftTypeIdentifier)

  }

  init(_ element: Requirement) {
    managedRequirement = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirement(self)
  }
}

class RequirementListProxy: ElementProxy, RequirementList {

  let managedRequirementList: RequirementList
  var requirements: [Requirement] {
    return managedRequirementList.requirements.map(proxy)

  }

  init(_ element: RequirementList) {
    managedRequirementList = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirementList(self)
  }
}

class SameTypeRequirementProxy: RequirementProxy, SameTypeRequirement {

  let managedSameTypeRequirement: SameTypeRequirement

  init(_ element: SameTypeRequirement) {
    managedSameTypeRequirement = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSameTypeRequirement(self)
  }
}

class SubscriptDeclarationProxy: ElementProxy, SubscriptDeclaration {

  let managedSubscriptDeclaration: SubscriptDeclaration
  var declarations: [Element] {
    return managedSubscriptDeclaration.declarations.map(proxy)

  }

  init(_ element: SubscriptDeclaration) {
    managedSubscriptDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSubscriptDeclaration(self)
  }
}

class TupleTypeProxy: TypeProxy, TupleType {

  let managedTupleType: TupleType
  var tupleTypeElementList: TupleTypeElementList {
    return proxy(managedTupleType.tupleTypeElementList)

  }

  init(_ element: TupleType) {
    managedTupleType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleType(self)
  }
}

class TupleTypeElementProxy: ElementProxy, TupleTypeElement {

  let managedTupleTypeElement: TupleTypeElement
  var typeAnnotation: TypeAnnotation? {
    return managedTupleTypeElement.typeAnnotation.flatMap(proxy)

  }
  var type: Type? {
    return managedTupleTypeElement.type.flatMap(proxy)

  }

  init(_ element: TupleTypeElement) {
    managedTupleTypeElement = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElement(self)
  }
}

class TupleTypeElementListProxy: ElementProxy, TupleTypeElementList {

  let managedTupleTypeElementList: TupleTypeElementList
  var tupleTypeElements: [TupleTypeElement] {
    return managedTupleTypeElementList.tupleTypeElements.map(proxy)

  }

  init(_ element: TupleTypeElementList) {
    managedTupleTypeElementList = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElementList(self)
  }
}

class TypeProxy: ElementProxy, Type {

  let managedType: Type

  init(_ element: Type) {
    managedType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitType(self)
  }
}

class TypeAnnotationProxy: ElementProxy, TypeAnnotation {

  let managedTypeAnnotation: TypeAnnotation
  var attributes: Attributes {
    return proxy(managedTypeAnnotation.attributes)

  }
  var type: Type {
    return proxy(managedTypeAnnotation.type)

  }

  init(_ element: TypeAnnotation) {
    managedTypeAnnotation = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeAnnotation(self)
  }
}

class TypeDeclarationProxy: ElementProxy, TypeDeclaration {

  let managedTypeDeclaration: TypeDeclaration
  var accessLevelModifier: AccessLevelModifier {
    return proxy(managedTypeDeclaration.accessLevelModifier)

  }
  var typeInheritanceClause: TypeInheritanceClause {
    return proxy(managedTypeDeclaration.typeInheritanceClause)

  }
  var codeBlock: CodeBlock {
    return proxy(managedTypeDeclaration.codeBlock)

  }

  init(_ element: TypeDeclaration) {
    managedTypeDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeDeclaration(self)
  }
}

class TypeIdentifierProxy: TypeProxy, TypeIdentifier {

  let managedTypeIdentifier: TypeIdentifier
  var parentType: TypeIdentifier? {
    return managedTypeIdentifier.parentType.flatMap(proxy)

  }
  var genericArgumentClause: GenericArgumentClause {
    return proxy(managedTypeIdentifier.genericArgumentClause)

  }

  init(_ element: TypeIdentifier) {
    managedTypeIdentifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeIdentifier(self)
  }
}

class TypeInheritanceClauseProxy: ElementProxy, TypeInheritanceClause {

  let managedTypeInheritanceClause: TypeInheritanceClause
  var inheritedTypes: [Type] {
    return managedTypeInheritanceClause.inheritedTypes.map(proxy)

  }

  init(_ element: TypeInheritanceClause) {
    managedTypeInheritanceClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeInheritanceClause(self)
  }
}

class TypealiasAssignmentProxy: ElementProxy, TypealiasAssignment {

  let managedTypealiasAssignment: TypealiasAssignment
  var type: Type {
    return proxy(managedTypealiasAssignment.type)

  }

  init(_ element: TypealiasAssignment) {
    managedTypealiasAssignment = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasAssignment(self)
  }
}

class TypealiasDeclarationProxy: ElementProxy, TypealiasDeclaration {

  let managedTypealiasDeclaration: TypealiasDeclaration
  var typealiasAssignment: TypealiasAssignment {
    return proxy(managedTypealiasDeclaration.typealiasAssignment)

  }

  init(_ element: TypealiasDeclaration) {
    managedTypealiasDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasDeclaration(self)
  }
}

class VariableDeclarationProxy: DeclarationProxy, VariableDeclaration {

  let managedVariableDeclaration: VariableDeclaration
  var typeAnnotation: TypeAnnotation {
    return proxy(managedVariableDeclaration.typeAnnotation)

  }
  var getterSetterKeywordBlock: GetterSetterKeywordBlock {
    return proxy(managedVariableDeclaration.getterSetterKeywordBlock)

  }
  var declarations: [Element] {
    return managedVariableDeclaration.declarations.map(proxy)

  }

  init(_ element: VariableDeclaration) {
    managedVariableDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitVariableDeclaration(self)
  }
}

class WhitespaceProxy: LeafNodeProxy, Whitespace {

  let managedWhitespace: Whitespace

  init(_ element: Whitespace) {
    managedWhitespace = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitWhitespace(self)
  }
}
