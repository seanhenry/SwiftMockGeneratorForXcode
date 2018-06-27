// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



class AccessLevelModifierWrapper: DeclarationModifierWrapper, AccessLevelModifier {

  let managedAccessLevelModifier: AccessLevelModifier

  init(_ element: AccessLevelModifier) {
    managedAccessLevelModifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAccessLevelModifier(self)
  }
}

class ArrayTypeWrapper: TypeWrapper, ArrayType {

  let managedArrayType: ArrayType
  var elementType: Type {
    return wrap(managedArrayType.elementType)
  }

  init(_ element: ArrayType) {
    managedArrayType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayType(self)
  }
}

class AssociatedTypeDeclarationWrapper: DeclarationWrapper, AssociatedTypeDeclaration {

  let managedAssociatedTypeDeclaration: AssociatedTypeDeclaration
  var typeInheritanceClause: [Element] {
    return managedAssociatedTypeDeclaration.typeInheritanceClause.map(wrap)
  }
  var typealiasAssignment: TypealiasAssignment? {
    return managedAssociatedTypeDeclaration.typealiasAssignment.flatMap(wrap)
  }
  var genericWhereClause: GenericWhereClause? {
    return managedAssociatedTypeDeclaration.genericWhereClause.flatMap(wrap)
  }

  init(_ element: AssociatedTypeDeclaration) {
    managedAssociatedTypeDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAssociatedTypeDeclaration(self)
  }
}

class AttributeWrapper: ElementWrapper, Attribute {

  let managedAttribute: Attribute

  init(_ element: Attribute) {
    managedAttribute = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttribute(self)
  }
}

class AttributesWrapper: ElementWrapper, Attributes {

  let managedAttributes: Attributes
  var attributes: [Attribute] {
    return managedAttributes.attributes.map(wrap)
  }

  init(_ element: Attributes) {
    managedAttributes = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttributes(self)
  }
}

class CodeBlockWrapper: ElementWrapper, CodeBlock {

  let managedCodeBlock: CodeBlock

  init(_ element: CodeBlock) {
    managedCodeBlock = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCodeBlock(self)
  }
}

class ConformanceRequirementWrapper: RequirementWrapper, ConformanceRequirement {

  let managedConformanceRequirement: ConformanceRequirement
  var rightTypeIdentifier: TypeIdentifier {
    return wrap(managedConformanceRequirement.rightTypeIdentifier)
  }
  var rightProtocolCompositionType: ProtocolCompositionType {
    return wrap(managedConformanceRequirement.rightProtocolCompositionType)
  }

  init(_ element: ConformanceRequirement) {
    managedConformanceRequirement = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitConformanceRequirement(self)
  }
}

class DeclarationWrapper: ElementWrapper, Declaration {

  let managedDeclaration: Declaration
  var attributes: Attributes {
    return wrap(managedDeclaration.attributes)
  }
  var accessLevelModifier: AccessLevelModifier {
    return wrap(managedDeclaration.accessLevelModifier)
  }

  init(_ element: Declaration) {
    managedDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclaration(self)
  }
}

class DeclarationModifierWrapper: ElementWrapper, DeclarationModifier {

  let managedDeclarationModifier: DeclarationModifier

  init(_ element: DeclarationModifier) {
    managedDeclarationModifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclarationModifier(self)
  }
}

class DictionaryTypeWrapper: TypeWrapper, DictionaryType {

  let managedDictionaryType: DictionaryType
  var keyType: Type {
    return wrap(managedDictionaryType.keyType)
  }
  var valueType: Type {
    return wrap(managedDictionaryType.valueType)
  }

  init(_ element: DictionaryType) {
    managedDictionaryType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryType(self)
  }
}

class FileWrapper: ElementWrapper, File {

  let managedFile: File
  var topLevelDeclarations: [Element] {
    return managedFile.topLevelDeclarations.map(wrap)
  }

  init(_ element: File) {
    managedFile = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFile(self)
  }
}

class FunctionDeclarationWrapper: ElementWrapper, FunctionDeclaration {

  let managedFunctionDeclaration: FunctionDeclaration
  var genericParameterClause: GenericParameterClause? {
    return managedFunctionDeclaration.genericParameterClause.flatMap(wrap)
  }
  var parameterClause: ParameterClause {
    return wrap(managedFunctionDeclaration.parameterClause)
  }
  var returnType: FunctionResult? {
    return managedFunctionDeclaration.returnType.flatMap(wrap)
  }
  var declarations: [Element] {
    return managedFunctionDeclaration.declarations.map(wrap)
  }

  init(_ element: FunctionDeclaration) {
    managedFunctionDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionDeclaration(self)
  }
}

class FunctionResultWrapper: ElementWrapper, FunctionResult {

  let managedFunctionResult: FunctionResult
  var attributes: Attributes {
    return wrap(managedFunctionResult.attributes)
  }
  var type: Type {
    return wrap(managedFunctionResult.type)
  }

  init(_ element: FunctionResult) {
    managedFunctionResult = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionResult(self)
  }
}

class FunctionTypeWrapper: TypeWrapper, FunctionType {

  let managedFunctionType: FunctionType
  var attributes: Attributes {
    return wrap(managedFunctionType.attributes)
  }
  var arguments: TupleType {
    return wrap(managedFunctionType.arguments)
  }
  var returnType: Type {
    return wrap(managedFunctionType.returnType)
  }

  init(_ element: FunctionType) {
    managedFunctionType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionType(self)
  }
}

class GenericArgumentClauseWrapper: ElementWrapper, GenericArgumentClause {

  let managedGenericArgumentClause: GenericArgumentClause
  var arguments: [Type] {
    return managedGenericArgumentClause.arguments.map(wrap)
  }

  init(_ element: GenericArgumentClause) {
    managedGenericArgumentClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericArgumentClause(self)
  }
}

class GenericParameterWrapper: ElementWrapper, GenericParameter {

  let managedGenericParameter: GenericParameter
  var typeIdentifier: TypeIdentifier? {
    return managedGenericParameter.typeIdentifier.flatMap(wrap)
  }
  var protocolComposition: ProtocolCompositionType? {
    return managedGenericParameter.protocolComposition.flatMap(wrap)
  }

  init(_ element: GenericParameter) {
    managedGenericParameter = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameter(self)
  }
}

class GenericParameterClauseWrapper: ElementWrapper, GenericParameterClause {

  let managedGenericParameterClause: GenericParameterClause
  var parameters: [GenericParameter] {
    return managedGenericParameterClause.parameters.map(wrap)
  }

  init(_ element: GenericParameterClause) {
    managedGenericParameterClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameterClause(self)
  }
}

class GenericWhereClauseWrapper: ElementWrapper, GenericWhereClause {

  let managedGenericWhereClause: GenericWhereClause
  var requirementList: RequirementList {
    return wrap(managedGenericWhereClause.requirementList)
  }

  init(_ element: GenericWhereClause) {
    managedGenericWhereClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericWhereClause(self)
  }
}

class GetterSetterKeywordBlockWrapper: ElementWrapper, GetterSetterKeywordBlock {

  let managedGetterSetterKeywordBlock: GetterSetterKeywordBlock
  var getterKeywordClause: GetterSetterKeywordClause {
    return wrap(managedGetterSetterKeywordBlock.getterKeywordClause)
  }
  var setterKeywordClause: GetterSetterKeywordClause? {
    return managedGetterSetterKeywordBlock.setterKeywordClause.flatMap(wrap)
  }

  init(_ element: GetterSetterKeywordBlock) {
    managedGetterSetterKeywordBlock = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGetterSetterKeywordBlock(self)
  }
}

class GetterSetterKeywordClauseWrapper: ElementWrapper, GetterSetterKeywordClause {

  let managedGetterSetterKeywordClause: GetterSetterKeywordClause
  var attributes: Attributes {
    return wrap(managedGetterSetterKeywordClause.attributes)
  }
  var mutationModifier: MutationModifier {
    return wrap(managedGetterSetterKeywordClause.mutationModifier)
  }

  init(_ element: GetterSetterKeywordClause) {
    managedGetterSetterKeywordClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGetterSetterKeywordClause(self)
  }
}

class IdentifierWrapper: LeafNodeWrapper, Identifier {

  let managedIdentifier: Identifier

  init(_ element: Identifier) {
    managedIdentifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifier(self)
  }
}

class InitializerDeclarationWrapper: ElementWrapper, InitializerDeclaration {

  let managedInitializerDeclaration: InitializerDeclaration
  var parameterClause: ParameterClause {
    return wrap(managedInitializerDeclaration.parameterClause)
  }
  var declarations: [Element] {
    return managedInitializerDeclaration.declarations.map(wrap)
  }

  init(_ element: InitializerDeclaration) {
    managedInitializerDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitInitializerDeclaration(self)
  }
}

class LeafNodeWrapper: ElementWrapper, LeafNode {

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

class MutationModifierWrapper: DeclarationModifierWrapper, MutationModifier {

  let managedMutationModifier: MutationModifier

  init(_ element: MutationModifier) {
    managedMutationModifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitMutationModifier(self)
  }
}

class OptionalTypeWrapper: TypeWrapper, OptionalType {

  let managedOptionalType: OptionalType
  var type: Type {
    return wrap(managedOptionalType.type)
  }

  init(_ element: OptionalType) {
    managedOptionalType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitOptionalType(self)
  }
}

class ParameterWrapper: ElementWrapper, Parameter {

  let managedParameter: Parameter
  var typeAnnotation: TypeAnnotation {
    return wrap(managedParameter.typeAnnotation)
  }

  init(_ element: Parameter) {
    managedParameter = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameter(self)
  }
}

class ParameterClauseWrapper: ElementWrapper, ParameterClause {

  let managedParameterClause: ParameterClause
  var parameters: [Parameter] {
    return managedParameterClause.parameters.map(wrap)
  }

  init(_ element: ParameterClause) {
    managedParameterClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameterClause(self)
  }
}

class ProtocolCompositionTypeWrapper: TypeWrapper, ProtocolCompositionType {

  let managedProtocolCompositionType: ProtocolCompositionType
  var types: [Type] {
    return managedProtocolCompositionType.types.map(wrap)
  }

  init(_ element: ProtocolCompositionType) {
    managedProtocolCompositionType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitProtocolCompositionType(self)
  }
}

class RequirementWrapper: ElementWrapper, Requirement {

  let managedRequirement: Requirement
  var leftTypeIdentifier: TypeIdentifier {
    return wrap(managedRequirement.leftTypeIdentifier)
  }

  init(_ element: Requirement) {
    managedRequirement = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirement(self)
  }
}

class RequirementListWrapper: ElementWrapper, RequirementList {

  let managedRequirementList: RequirementList
  var requirements: [Requirement] {
    return managedRequirementList.requirements.map(wrap)
  }

  init(_ element: RequirementList) {
    managedRequirementList = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirementList(self)
  }
}

class SameTypeRequirementWrapper: RequirementWrapper, SameTypeRequirement {

  let managedSameTypeRequirement: SameTypeRequirement
  var rightType: Type {
    return wrap(managedSameTypeRequirement.rightType)
  }

  init(_ element: SameTypeRequirement) {
    managedSameTypeRequirement = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSameTypeRequirement(self)
  }
}

class SubscriptDeclarationWrapper: ElementWrapper, SubscriptDeclaration {

  let managedSubscriptDeclaration: SubscriptDeclaration
  var declarations: [Element] {
    return managedSubscriptDeclaration.declarations.map(wrap)
  }

  init(_ element: SubscriptDeclaration) {
    managedSubscriptDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSubscriptDeclaration(self)
  }
}

class TupleTypeWrapper: TypeWrapper, TupleType {

  let managedTupleType: TupleType
  var tupleTypeElementList: TupleTypeElementList {
    return wrap(managedTupleType.tupleTypeElementList)
  }

  init(_ element: TupleType) {
    managedTupleType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleType(self)
  }
}

class TupleTypeElementWrapper: ElementWrapper, TupleTypeElement {

  let managedTupleTypeElement: TupleTypeElement
  var typeAnnotation: TypeAnnotation? {
    return managedTupleTypeElement.typeAnnotation.flatMap(wrap)
  }
  var type: Type? {
    return managedTupleTypeElement.type.flatMap(wrap)
  }

  init(_ element: TupleTypeElement) {
    managedTupleTypeElement = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElement(self)
  }
}

class TupleTypeElementListWrapper: ElementWrapper, TupleTypeElementList {

  let managedTupleTypeElementList: TupleTypeElementList
  var tupleTypeElements: [TupleTypeElement] {
    return managedTupleTypeElementList.tupleTypeElements.map(wrap)
  }

  init(_ element: TupleTypeElementList) {
    managedTupleTypeElementList = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElementList(self)
  }
}

class TypeWrapper: ElementWrapper, Type {

  let managedType: Type

  init(_ element: Type) {
    managedType = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitType(self)
  }
}

class TypeAnnotationWrapper: ElementWrapper, TypeAnnotation {

  let managedTypeAnnotation: TypeAnnotation
  var attributes: Attributes {
    return wrap(managedTypeAnnotation.attributes)
  }
  var type: Type {
    return wrap(managedTypeAnnotation.type)
  }

  init(_ element: TypeAnnotation) {
    managedTypeAnnotation = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeAnnotation(self)
  }
}

class TypeDeclarationWrapper: ElementWrapper, TypeDeclaration {

  let managedTypeDeclaration: TypeDeclaration
  var accessLevelModifier: AccessLevelModifier {
    return wrap(managedTypeDeclaration.accessLevelModifier)
  }
  var typeInheritanceClause: TypeInheritanceClause {
    return wrap(managedTypeDeclaration.typeInheritanceClause)
  }
  var codeBlock: CodeBlock {
    return wrap(managedTypeDeclaration.codeBlock)
  }

  init(_ element: TypeDeclaration) {
    managedTypeDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeDeclaration(self)
  }
}

class TypeIdentifierWrapper: TypeWrapper, TypeIdentifier {

  let managedTypeIdentifier: TypeIdentifier
  var parentType: TypeIdentifier? {
    return managedTypeIdentifier.parentType.flatMap(wrap)
  }
  var genericArgumentClause: GenericArgumentClause {
    return wrap(managedTypeIdentifier.genericArgumentClause)
  }

  init(_ element: TypeIdentifier) {
    managedTypeIdentifier = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeIdentifier(self)
  }
}

class TypeInheritanceClauseWrapper: ElementWrapper, TypeInheritanceClause {

  let managedTypeInheritanceClause: TypeInheritanceClause
  var inheritedTypes: [Type] {
    return managedTypeInheritanceClause.inheritedTypes.map(wrap)
  }

  init(_ element: TypeInheritanceClause) {
    managedTypeInheritanceClause = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeInheritanceClause(self)
  }
}

class TypealiasAssignmentWrapper: ElementWrapper, TypealiasAssignment {

  let managedTypealiasAssignment: TypealiasAssignment
  var type: Type {
    return wrap(managedTypealiasAssignment.type)
  }

  init(_ element: TypealiasAssignment) {
    managedTypealiasAssignment = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasAssignment(self)
  }
}

class TypealiasDeclarationWrapper: ElementWrapper, TypealiasDeclaration {

  let managedTypealiasDeclaration: TypealiasDeclaration
  var typealiasAssignment: TypealiasAssignment {
    return wrap(managedTypealiasDeclaration.typealiasAssignment)
  }

  init(_ element: TypealiasDeclaration) {
    managedTypealiasDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasDeclaration(self)
  }
}

class VariableDeclarationWrapper: DeclarationWrapper, VariableDeclaration {

  let managedVariableDeclaration: VariableDeclaration
  var typeAnnotation: TypeAnnotation {
    return wrap(managedVariableDeclaration.typeAnnotation)
  }
  var getterSetterKeywordBlock: GetterSetterKeywordBlock {
    return wrap(managedVariableDeclaration.getterSetterKeywordBlock)
  }
  var declarations: [Element] {
    return managedVariableDeclaration.declarations.map(wrap)
  }

  init(_ element: VariableDeclaration) {
    managedVariableDeclaration = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitVariableDeclaration(self)
  }
}

class WhitespaceWrapper: LeafNodeWrapper, Whitespace {

  let managedWhitespace: Whitespace

  init(_ element: Whitespace) {
    managedWhitespace = element
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitWhitespace(self)
  }
}
