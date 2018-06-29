// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



class AccessLevelModifierImpl: DeclarationModifierImpl,
 AccessLevelModifier {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAccessLevelModifier(self)
  }
}

class ArrayLiteralExpressionImpl: LiteralExpressionImpl,
 ArrayLiteralExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayLiteralExpression(self)
  }
}

class ArrayLiteralItemImpl: ElementImpl, ArrayLiteralItem {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayLiteralItem(self)
  }
}

class ArrayLiteralItemsImpl: ElementImpl, ArrayLiteralItems {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayLiteralItems(self)
  }
}

class ArrayTypeImpl: TypeImpl,
 ArrayType {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayType(self)
  }
}

class AssociatedTypeDeclarationImpl: DeclarationImpl,
 AssociatedTypeDeclaration {

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

class CaptureListImpl: ElementImpl, CaptureList {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCaptureList(self)
  }
}

class CaptureListItemImpl: ElementImpl, CaptureListItem {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCaptureListItem(self)
  }
}

class CaptureListItemsImpl: ElementImpl, CaptureListItems {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCaptureListItems(self)
  }
}

class ClassDeclarationImpl: ElementImpl, ClassDeclaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClassDeclaration(self)
  }
}

class ClosureExpressionImpl: PrimaryExpressionImpl,
 ClosureExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureExpression(self)
  }
}

class ClosureParameterImpl: ElementImpl, ClosureParameter {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureParameter(self)
  }
}

class ClosureParameterClauseImpl: ElementImpl, ClosureParameterClause {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureParameterClause(self)
  }
}

class ClosureParameterListImpl: ElementImpl, ClosureParameterList {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureParameterList(self)
  }
}

class ClosureSignatureImpl: ElementImpl, ClosureSignature {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureSignature(self)
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

class ConformanceRequirementImpl: RequirementImpl,
 ConformanceRequirement {

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

class DictionaryLiteralExpressionImpl: LiteralExpressionImpl,
 DictionaryLiteralExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryLiteralExpression(self)
  }
}

class DictionaryLiteralItemImpl: ElementImpl, DictionaryLiteralItem {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryLiteralItem(self)
  }
}

class DictionaryLiteralItemsImpl: ElementImpl, DictionaryLiteralItems {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryLiteralItems(self)
  }
}

class DictionaryTypeImpl: TypeImpl,
 DictionaryType {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryType(self)
  }
}

class ExpressionImpl: ElementImpl, Expression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitExpression(self)
  }
}

class FunctionCallArgumentImpl: ElementImpl, FunctionCallArgument {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionCallArgument(self)
  }
}

class FunctionCallArgumentClauseImpl: ElementImpl, FunctionCallArgumentClause {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionCallArgumentClause(self)
  }
}

class FunctionCallArgumentListImpl: ElementImpl, FunctionCallArgumentList {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionCallArgumentList(self)
  }
}

class FunctionCallExpressionImpl: PostfixExpressionImpl,
 FunctionCallExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionCallExpression(self)
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

class FunctionTypeImpl: TypeImpl,
 FunctionType {

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

class IdentifierImpl: LeafNodeImpl,
 Identifier {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifier(self)
  }
}

class IdentifierListImpl: ElementImpl, IdentifierList {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifierList(self)
  }
}

class IdentifierPrimaryExpressionImpl: PrimaryExpressionImpl,
 IdentifierPrimaryExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifierPrimaryExpression(self)
  }
}

class ImplicitMemberExpressionImpl: PrimaryExpressionImpl,
 ImplicitMemberExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitImplicitMemberExpression(self)
  }
}

class InOutExpressionImpl: PrefixExpressionImpl,
 InOutExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitInOutExpression(self)
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

class KeyPathComponentImpl: ElementImpl, KeyPathComponent {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathComponent(self)
  }
}

class KeyPathComponentsImpl: ElementImpl, KeyPathComponents {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathComponents(self)
  }
}

class KeyPathExpressionImpl: PrimaryExpressionImpl,
 KeyPathExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathExpression(self)
  }
}

class KeyPathPostfixImpl: ElementImpl, KeyPathPostfix {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathPostfix(self)
  }
}

class KeyPathPostfixesImpl: ElementImpl, KeyPathPostfixes {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathPostfixes(self)
  }
}

class KeyPathStringExpressionImpl: PrimaryExpressionImpl,
 KeyPathStringExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathStringExpression(self)
  }
}

class KeywordLiteralExpressionImpl: LiteralExpressionImpl,
 KeywordLiteralExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeywordLiteralExpression(self)
  }
}

class LiteralExpressionImpl: PrimaryExpressionImpl,
 LiteralExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitLiteralExpression(self)
  }
}

class MutationModifierImpl: DeclarationModifierImpl,
 MutationModifier {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitMutationModifier(self)
  }
}

class OperatorPostfixExpressionImpl: PostfixExpressionImpl,
 OperatorPostfixExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitOperatorPostfixExpression(self)
  }
}

class OptionalTypeImpl: TypeImpl,
 OptionalType {

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

class ParenthesizedExpressionImpl: PrimaryExpressionImpl,
 ParenthesizedExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParenthesizedExpression(self)
  }
}

class PlaygroundLiteralArgumentImpl: ElementImpl, PlaygroundLiteralArgument {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPlaygroundLiteralArgument(self)
  }
}

class PlaygroundLiteralArgumentsImpl: ElementImpl, PlaygroundLiteralArguments {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPlaygroundLiteralArguments(self)
  }
}

class PlaygroundLiteralExpressionImpl: LiteralExpressionImpl,
 PlaygroundLiteralExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPlaygroundLiteralExpression(self)
  }
}

class PostfixExpressionImpl: ExpressionImpl,
 PostfixExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPostfixExpression(self)
  }
}

class PostfixSelfExpressionImpl: PostfixExpressionImpl,
 PostfixSelfExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPostfixSelfExpression(self)
  }
}

class PrefixExpressionImpl: ExpressionImpl,
 PrefixExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPrefixExpression(self)
  }
}

class PrimaryExpressionImpl: PostfixExpressionImpl,
 PrimaryExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPrimaryExpression(self)
  }
}

class ProtocolCompositionTypeImpl: TypeImpl,
 ProtocolCompositionType {

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

class SameTypeRequirementImpl: RequirementImpl,
 SameTypeRequirement {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSameTypeRequirement(self)
  }
}

class SelectorExpressionImpl: PrimaryExpressionImpl,
 SelectorExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelectorExpression(self)
  }
}

class SelfExpressionImpl: PrimaryExpressionImpl,
 SelfExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelfExpression(self)
  }
}

class SelfInitializerExpressionImpl: SelfExpressionImpl,
 SelfInitializerExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelfInitializerExpression(self)
  }
}

class SelfMethodExpressionImpl: SelfExpressionImpl,
 SelfMethodExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelfMethodExpression(self)
  }
}

class SelfSubscriptExpressionImpl: SelfExpressionImpl,
 SelfSubscriptExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelfSubscriptExpression(self)
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

class SuperclassExpressionImpl: PrimaryExpressionImpl,
 SuperclassExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSuperclassExpression(self)
  }
}

class SuperclassInitializerExpressionImpl: PrimaryExpressionImpl,
 SuperclassInitializerExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSuperclassInitializerExpression(self)
  }
}

class SuperclassMethodExpressionImpl: PrimaryExpressionImpl,
 SuperclassMethodExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSuperclassMethodExpression(self)
  }
}

class SuperclassSubscriptExpressionImpl: PrimaryExpressionImpl,
 SuperclassSubscriptExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSuperclassSubscriptExpression(self)
  }
}

class TupleTypeImpl: TypeImpl,
 TupleType {

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

class TypeIdentifierImpl: TypeImpl,
 TypeIdentifier {

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

class VariableDeclarationImpl: DeclarationImpl,
 VariableDeclaration {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitVariableDeclaration(self)
  }
}

class WhitespaceImpl: LeafNodeImpl,
 Whitespace {

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitWhitespace(self)
  }
}

class WildcardExpressionImpl: PrimaryExpressionImpl,
 WildcardExpression {

  override init(children: [Element]) {
    super.init(children: children)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitWildcardExpression(self)
  }
}
