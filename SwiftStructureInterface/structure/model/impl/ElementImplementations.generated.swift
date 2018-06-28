// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



class AccessLevelModifierImpl: DeclarationModifierImpl, AccessLevelModifier {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAccessLevelModifier(self)
  }
}

class ArrayTypeImpl: TypeImpl, ArrayType {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayType(self)
  }
}

class AssociatedTypeDeclarationImpl: DeclarationImpl, AssociatedTypeDeclaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAssociatedTypeDeclaration(self)
  }
}

class AttributeImpl: ElementImpl, Attribute {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttribute(self)
  }
}

class AttributesImpl: ElementImpl, Attributes {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttributes(self)
  }
}

class CodeBlockImpl: ElementImpl, CodeBlock {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCodeBlock(self)
  }
}

class ConformanceRequirementImpl: RequirementImpl, ConformanceRequirement {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitConformanceRequirement(self)
  }
}

class DeclarationImpl: ElementImpl, Declaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclaration(self)
  }
}

class DeclarationModifierImpl: ElementImpl, DeclarationModifier {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclarationModifier(self)
  }
}

class DictionaryTypeImpl: TypeImpl, DictionaryType {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryType(self)
  }
}

class FunctionDeclarationImpl: ElementImpl, FunctionDeclaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionDeclaration(self)
  }
}

class FunctionResultImpl: ElementImpl, FunctionResult {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionResult(self)
  }
}

class FunctionTypeImpl: TypeImpl, FunctionType {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionType(self)
  }
}

class GenericArgumentClauseImpl: ElementImpl, GenericArgumentClause {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericArgumentClause(self)
  }
}

class GenericParameterImpl: ElementImpl, GenericParameter {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameter(self)
  }
}

class GenericParameterClauseImpl: ElementImpl, GenericParameterClause {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameterClause(self)
  }
}

class GenericWhereClauseImpl: ElementImpl, GenericWhereClause {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericWhereClause(self)
  }
}

class GetterSetterKeywordBlockImpl: ElementImpl, GetterSetterKeywordBlock {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGetterSetterKeywordBlock(self)
  }
}

class GetterSetterKeywordClauseImpl: ElementImpl, GetterSetterKeywordClause {

  override init(children: [Element]) {
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

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitInitializerDeclaration(self)
  }
}

class MutationModifierImpl: DeclarationModifierImpl, MutationModifier {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitMutationModifier(self)
  }
}

class OptionalTypeImpl: TypeImpl, OptionalType {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitOptionalType(self)
  }
}

class ParameterImpl: ElementImpl, Parameter {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameter(self)
  }
}

class ParameterClauseImpl: ElementImpl, ParameterClause {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameterClause(self)
  }
}

class ProtocolCompositionTypeImpl: TypeImpl, ProtocolCompositionType {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitProtocolCompositionType(self)
  }
}

class ProtocolDeclarationImpl: ElementImpl, ProtocolDeclaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitProtocolDeclaration(self)
  }
}

class RequirementImpl: ElementImpl, Requirement {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirement(self)
  }
}

class RequirementListImpl: ElementImpl, RequirementList {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirementList(self)
  }
}

class SameTypeRequirementImpl: RequirementImpl, SameTypeRequirement {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSameTypeRequirement(self)
  }
}

class SubscriptDeclarationImpl: ElementImpl, SubscriptDeclaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSubscriptDeclaration(self)
  }
}

class TupleTypeImpl: TypeImpl, TupleType {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleType(self)
  }
}

class TupleTypeElementImpl: ElementImpl, TupleTypeElement {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElement(self)
  }
}

class TupleTypeElementListImpl: ElementImpl, TupleTypeElementList {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElementList(self)
  }
}

class TypeImpl: ElementImpl, Type {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitType(self)
  }
}

class TypeAnnotationImpl: ElementImpl, TypeAnnotation {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeAnnotation(self)
  }
}

class TypeDeclarationImpl: ElementImpl, TypeDeclaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeDeclaration(self)
  }
}

class TypeIdentifierImpl: TypeImpl, TypeIdentifier {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeIdentifier(self)
  }
}

class TypeInheritanceClauseImpl: ElementImpl, TypeInheritanceClause {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeInheritanceClause(self)
  }
}

class TypealiasAssignmentImpl: ElementImpl, TypealiasAssignment {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasAssignment(self)
  }
}

class TypealiasDeclarationImpl: ElementImpl, TypealiasDeclaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasDeclaration(self)
  }
}

class VariableDeclarationImpl: DeclarationImpl, VariableDeclaration {

  override init(children: [Element]) {
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
