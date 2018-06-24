// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



class AccessLevelModifierImpl: DeclarationModifierImpl, AccessLevelModifier {


  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAccessLevelModifier(self)
  }
}

class ArrayTypeImpl: TypeImpl, ArrayType {


  var elementType: Type {
    return children.first { $0 is Type } as? Type ?? TypeImpl.emptyType
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayType(self)
  }
}

class AssociatedTypeDeclarationImpl: DeclarationImpl, AssociatedTypeDeclaration {


  var typeInheritanceClause: [Element] {
    return children.compactMap { $0 as? Element }
  }
  var typealiasAssignment: TypealiasAssignment? {
    return children.first { $0 is TypealiasAssignment } as? TypealiasAssignment
  }
  var genericWhereClause: GenericWhereClause? {
    return children.first { $0 is GenericWhereClause } as? GenericWhereClause
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAssociatedTypeDeclaration(self)
  }
}

class AttributeImpl: ElementImpl, Attribute {


  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttribute(self)
  }
}

class AttributesImpl: ElementImpl, Attributes {


  var attributes: [Attribute] {
    return children.compactMap { $0 as? Attribute }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttributes(self)
  }
}

class DeclarationImpl: ElementImpl, Declaration {


  var attributes: Attributes {
    return children.first { $0 is Attributes } as? Attributes ?? AttributesImpl.emptyAttributes
  }
  var accessLevelModifier: AccessLevelModifier {
    return children.first { $0 is AccessLevelModifier } as? AccessLevelModifier ?? AccessLevelModifierImpl.emptyAccessLevelModifier
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclaration(self)
  }
}

class DeclarationModifierImpl: ElementImpl, DeclarationModifier {


  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclarationModifier(self)
  }
}

class DictionaryTypeImpl: TypeImpl, DictionaryType {


  var keyType: Type {
    return children.first { $0 is Type } as? Type ?? TypeImpl.emptyType
  }
  var valueType: Type {
    return children.first { $0 is Type } as? Type ?? TypeImpl.emptyType
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryType(self)
  }
}

class FunctionDeclarationImpl: ElementImpl, FunctionDeclaration {


  var genericParameterClause: GenericParameterClause? {
    return children.first { $0 is GenericParameterClause } as? GenericParameterClause
  }
  var parameters: [Parameter] {
    return children.compactMap { $0 as? Parameter }
  }
  var returnType: Element? {
    return children.first { $0 is Element } as? Element
  }
  var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionDeclaration(self)
  }
}

class FunctionTypeImpl: TypeImpl, FunctionType {


  var attributes: Attributes {
    return children.first { $0 is Attributes } as? Attributes ?? AttributesImpl.emptyAttributes
  }
  var arguments: TupleType {
    return children.first { $0 is TupleType } as? TupleType ?? TupleTypeImpl.emptyTupleType
  }
  var returnType: Type {
    return children.first { $0 is Type } as? Type ?? TypeImpl.emptyType
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionType(self)
  }
}

class GenericArgumentClauseImpl: ElementImpl, GenericArgumentClause {


  var arguments: [Type] {
    return children.compactMap { $0 as? Type }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericArgumentClause(self)
  }
}

class GenericParameterImpl: ElementImpl, GenericParameter {


  var typeIdentifier: TypeIdentifier? {
    return children.first { $0 is TypeIdentifier } as? TypeIdentifier
  }
  var protocolComposition: ProtocolCompositionType? {
    return children.first { $0 is ProtocolCompositionType } as? ProtocolCompositionType
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameter(self)
  }
}

class GenericParameterClauseImpl: ElementImpl, GenericParameterClause {


  var parameters: [GenericParameter] {
    return children.compactMap { $0 as? GenericParameter }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameterClause(self)
  }
}

class GenericWhereClauseImpl: ElementImpl, GenericWhereClause {


  var requirementList: RequirementList {
    return children.first { $0 is RequirementList } as? RequirementList ?? RequirementListImpl.emptyRequirementList
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericWhereClause(self)
  }
}

class GetterSetterKeywordClauseImpl: ElementImpl, GetterSetterKeywordClause {


  var attributes: Attributes {
    return children.first { $0 is Attributes } as? Attributes ?? AttributesImpl.emptyAttributes
  }
  var mutationModifier: MutationModifier {
    return children.first { $0 is MutationModifier } as? MutationModifier ?? MutationModifierImpl.emptyMutationModifier
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGetterSetterKeywordClause(self)
  }
}

class IdentifierImpl: LeafNodeImpl, Identifier {



  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifier(self)
  }
}

class InitializerDeclarationImpl: ElementImpl, InitializerDeclaration {


  var parameters: [Parameter] {
    return children.compactMap { $0 as? Parameter }
  }
  var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitInitializerDeclaration(self)
  }
}

class MutationModifierImpl: DeclarationModifierImpl, MutationModifier {


  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitMutationModifier(self)
  }
}

class OptionalTypeImpl: TypeImpl, OptionalType {


  var type: Type {
    return children.first { $0 is Type } as? Type ?? TypeImpl.emptyType
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitOptionalType(self)
  }
}

class ParameterImpl: ElementImpl, Parameter {


  var typeAnnotation: TypeAnnotation {
    return children.first { $0 is TypeAnnotation } as? TypeAnnotation ?? TypeAnnotationImpl.emptyTypeAnnotation
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameter(self)
  }
}

class ProtocolCompositionTypeImpl: TypeImpl, ProtocolCompositionType {


  var types: [Type] {
    return children.compactMap { $0 as? Type }
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitProtocolCompositionType(self)
  }
}

class RequirementImpl: ElementImpl, Requirement {


  var leftTypeIdentifier: TypeIdentifier {
    return children.first { $0 is TypeIdentifier } as? TypeIdentifier ?? TypeIdentifierImpl.emptyTypeIdentifier
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirement(self)
  }
}

class RequirementListImpl: ElementImpl, RequirementList {


  var requirements: [Requirement] {
    return children.compactMap { $0 as? Requirement }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirementList(self)
  }
}

class SubscriptDeclarationImpl: ElementImpl, SubscriptDeclaration {


  var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSubscriptDeclaration(self)
  }
}

class TupleTypeImpl: TypeImpl, TupleType {


  var tupleTypeElementList: TupleTypeElementList {
    return children.first { $0 is TupleTypeElementList } as? TupleTypeElementList ?? TupleTypeElementListImpl.emptyTupleTypeElementList
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleType(self)
  }
}

class TupleTypeElementImpl: ElementImpl, TupleTypeElement {


  var typeAnnotation: TypeAnnotation? {
    return children.first { $0 is TypeAnnotation } as? TypeAnnotation
  }
  var type: Type? {
    return children.first { $0 is Type } as? Type
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElement(self)
  }
}

class TupleTypeElementListImpl: ElementImpl, TupleTypeElementList {


  var tupleTypeElements: [TupleTypeElement] {
    return children.compactMap { $0 as? TupleTypeElement }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElementList(self)
  }
}

class TypeImpl: ElementImpl, Type {


  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitType(self)
  }
}

class TypeAnnotationImpl: ElementImpl, TypeAnnotation {


  var attributes: Attributes {
    return children.first { $0 is Attributes } as? Attributes ?? AttributesImpl.emptyAttributes
  }
  var type: Type {
    return children.first { $0 is Type } as? Type ?? TypeImpl.emptyType
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeAnnotation(self)
  }
}

class TypeDeclarationImpl: ElementImpl, TypeDeclaration {


  var accessLevelModifier: AccessLevelModifier {
    return children.first { $0 is AccessLevelModifier } as? AccessLevelModifier ?? AccessLevelModifierImpl.emptyAccessLevelModifier
  }
  var inheritedTypes: [Element] {
    return children.compactMap { $0 as? Element }
  }
  var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeDeclaration(self)
  }
}

class TypeIdentifierImpl: TypeImpl, TypeIdentifier {


  var parentType: TypeIdentifier? {
    return children.first { $0 is TypeIdentifier } as? TypeIdentifier
  }
  var genericArgumentClause: GenericArgumentClause {
    return children.first { $0 is GenericArgumentClause } as? GenericArgumentClause ?? GenericArgumentClauseImpl.emptyGenericArgumentClause
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeIdentifier(self)
  }
}

class TypealiasAssignmentImpl: ElementImpl, TypealiasAssignment {


  var type: Type {
    return children.first { $0 is Type } as? Type ?? TypeImpl.emptyType
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasAssignment(self)
  }
}

class TypealiasDeclarationImpl: ElementImpl, TypealiasDeclaration {


  var typealiasAssignment: TypealiasAssignment {
    return children.first { $0 is TypealiasAssignment } as? TypealiasAssignment ?? TypealiasAssignmentImpl.emptyTypealiasAssignment
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasDeclaration(self)
  }
}

class VariableDeclarationImpl: DeclarationImpl, VariableDeclaration {


  var typeAnnotation: TypeAnnotation {
    return children.first { $0 is TypeAnnotation } as? TypeAnnotation ?? TypeAnnotationImpl.emptyTypeAnnotation
  }
  var getterSetterKeywordBlock: GetterSetterKeywordBlock {
    return children.first { $0 is GetterSetterKeywordBlock } as? GetterSetterKeywordBlock ?? GetterSetterKeywordBlockImpl.emptyGetterSetterKeywordBlock
  }
  var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
  override init(children: [Any?]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitVariableDeclaration(self)
  }
}

class WhitespaceImpl: LeafNodeImpl, Whitespace {



  override func accept(_ visitor: ElementVisitor) {
    visitor.visitWhitespace(self)
  }
}
