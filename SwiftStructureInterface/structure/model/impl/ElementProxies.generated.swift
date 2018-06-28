// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



class AccessLevelModifierProxy: DeclarationModifierProxy, AccessLevelModifier {

  init(_ element: AccessLevelModifier) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAccessLevelModifier(self)
  }
}

class ArrayTypeProxy: TypeProxy, ArrayType {

  init(_ element: ArrayType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayType(self)
  }
}

class AssociatedTypeDeclarationProxy: DeclarationProxy, AssociatedTypeDeclaration {

  init(_ element: AssociatedTypeDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAssociatedTypeDeclaration(self)
  }
}

class AttributeProxy: ElementProxy, Attribute {

  init(_ element: Attribute) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttribute(self)
  }
}

class AttributesProxy: ElementProxy, Attributes {

  init(_ element: Attributes) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAttributes(self)
  }
}

class CodeBlockProxy: ElementProxy, CodeBlock {

  init(_ element: CodeBlock) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCodeBlock(self)
  }
}

class ConformanceRequirementProxy: RequirementProxy, ConformanceRequirement {

  init(_ element: ConformanceRequirement) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitConformanceRequirement(self)
  }
}

class DeclarationProxy: ElementProxy, Declaration {

  init(_ element: Declaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclaration(self)
  }
}

class DeclarationModifierProxy: ElementProxy, DeclarationModifier {

  init(_ element: DeclarationModifier) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDeclarationModifier(self)
  }
}

class DictionaryTypeProxy: TypeProxy, DictionaryType {

  init(_ element: DictionaryType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryType(self)
  }
}

class FileProxy: ElementProxy, File {

  init(_ element: File) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFile(self)
  }
}

class FunctionDeclarationProxy: ElementProxy, FunctionDeclaration {

  init(_ element: FunctionDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionDeclaration(self)
  }
}

class FunctionResultProxy: ElementProxy, FunctionResult {

  init(_ element: FunctionResult) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionResult(self)
  }
}

class FunctionTypeProxy: TypeProxy, FunctionType {

  init(_ element: FunctionType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionType(self)
  }
}

class GenericArgumentClauseProxy: ElementProxy, GenericArgumentClause {

  init(_ element: GenericArgumentClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericArgumentClause(self)
  }
}

class GenericParameterProxy: ElementProxy, GenericParameter {

  init(_ element: GenericParameter) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameter(self)
  }
}

class GenericParameterClauseProxy: ElementProxy, GenericParameterClause {

  init(_ element: GenericParameterClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericParameterClause(self)
  }
}

class GenericWhereClauseProxy: ElementProxy, GenericWhereClause {

  init(_ element: GenericWhereClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGenericWhereClause(self)
  }
}

class GetterSetterKeywordBlockProxy: ElementProxy, GetterSetterKeywordBlock {

  init(_ element: GetterSetterKeywordBlock) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGetterSetterKeywordBlock(self)
  }
}

class GetterSetterKeywordClauseProxy: ElementProxy, GetterSetterKeywordClause {

  init(_ element: GetterSetterKeywordClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitGetterSetterKeywordClause(self)
  }
}

class IdentifierProxy: LeafNodeProxy, Identifier {

  init(_ element: Identifier) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifier(self)
  }
}

class InitializerDeclarationProxy: ElementProxy, InitializerDeclaration {

  init(_ element: InitializerDeclaration) {
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

  init(_ element: MutationModifier) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitMutationModifier(self)
  }
}

class OptionalTypeProxy: TypeProxy, OptionalType {

  init(_ element: OptionalType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitOptionalType(self)
  }
}

class ParameterProxy: ElementProxy, Parameter {

  init(_ element: Parameter) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameter(self)
  }
}

class ParameterClauseProxy: ElementProxy, ParameterClause {

  init(_ element: ParameterClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParameterClause(self)
  }
}

class ProtocolCompositionTypeProxy: TypeProxy, ProtocolCompositionType {

  init(_ element: ProtocolCompositionType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitProtocolCompositionType(self)
  }
}

class ProtocolDeclarationProxy: ElementProxy, ProtocolDeclaration {

  init(_ element: ProtocolDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitProtocolDeclaration(self)
  }
}

class RequirementProxy: ElementProxy, Requirement {

  init(_ element: Requirement) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirement(self)
  }
}

class RequirementListProxy: ElementProxy, RequirementList {

  init(_ element: RequirementList) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitRequirementList(self)
  }
}

class SameTypeRequirementProxy: RequirementProxy, SameTypeRequirement {

  init(_ element: SameTypeRequirement) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSameTypeRequirement(self)
  }
}

class SubscriptDeclarationProxy: ElementProxy, SubscriptDeclaration {

  init(_ element: SubscriptDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSubscriptDeclaration(self)
  }
}

class TupleTypeProxy: TypeProxy, TupleType {

  init(_ element: TupleType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleType(self)
  }
}

class TupleTypeElementProxy: ElementProxy, TupleTypeElement {

  init(_ element: TupleTypeElement) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElement(self)
  }
}

class TupleTypeElementListProxy: ElementProxy, TupleTypeElementList {

  init(_ element: TupleTypeElementList) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleTypeElementList(self)
  }
}

class TypeProxy: ElementProxy, Type {

  init(_ element: Type) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitType(self)
  }
}

class TypeAnnotationProxy: ElementProxy, TypeAnnotation {

  init(_ element: TypeAnnotation) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeAnnotation(self)
  }
}

class TypeDeclarationProxy: ElementProxy, TypeDeclaration {

  init(_ element: TypeDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeDeclaration(self)
  }
}

class TypeIdentifierProxy: TypeProxy, TypeIdentifier {

  init(_ element: TypeIdentifier) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeIdentifier(self)
  }
}

class TypeInheritanceClauseProxy: ElementProxy, TypeInheritanceClause {

  init(_ element: TypeInheritanceClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeInheritanceClause(self)
  }
}

class TypealiasAssignmentProxy: ElementProxy, TypealiasAssignment {

  init(_ element: TypealiasAssignment) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasAssignment(self)
  }
}

class TypealiasDeclarationProxy: ElementProxy, TypealiasDeclaration {

  init(_ element: TypealiasDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasDeclaration(self)
  }
}

class VariableDeclarationProxy: DeclarationProxy, VariableDeclaration {

  init(_ element: VariableDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitVariableDeclaration(self)
  }
}

class WhitespaceProxy: LeafNodeProxy, Whitespace {

  init(_ element: Whitespace) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitWhitespace(self)
  }
}
