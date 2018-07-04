// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



class AccessLevelModifierProxy: DeclarationModifierProxy,
 AccessLevelModifier {

  init(_ element: AccessLevelModifier) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitAccessLevelModifier(self)
  }
}

class ArgumentNameProxy: ElementProxy, ArgumentName {

  init(_ element: ArgumentName) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArgumentName(self)
  }
}

class ArgumentNamesProxy: ElementProxy, ArgumentNames {

  init(_ element: ArgumentNames) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArgumentNames(self)
  }
}

class ArrayLiteralExpressionProxy: LiteralExpressionProxy,
 ArrayLiteralExpression {

  init(_ element: ArrayLiteralExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayLiteralExpression(self)
  }
}

class ArrayLiteralItemProxy: ElementProxy, ArrayLiteralItem {

  init(_ element: ArrayLiteralItem) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayLiteralItem(self)
  }
}

class ArrayLiteralItemsProxy: ElementProxy, ArrayLiteralItems {

  init(_ element: ArrayLiteralItems) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayLiteralItems(self)
  }
}

class ArrayTypeProxy: TypeProxy,
 ArrayType {

  init(_ element: ArrayType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitArrayType(self)
  }
}

class AssociatedTypeDeclarationProxy: DeclarationProxy,
 AssociatedTypeDeclaration {

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

class BinaryExpressionProxy: ElementProxy, BinaryExpression {

  init(_ element: BinaryExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitBinaryExpression(self)
  }
}

class CaptureListProxy: ElementProxy, CaptureList {

  init(_ element: CaptureList) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCaptureList(self)
  }
}

class CaptureListItemProxy: ElementProxy, CaptureListItem {

  init(_ element: CaptureListItem) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCaptureListItem(self)
  }
}

class CaptureListItemsProxy: ElementProxy, CaptureListItems {

  init(_ element: CaptureListItems) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitCaptureListItems(self)
  }
}

class ClassDeclarationProxy: DeclarationProxy,
 ClassDeclaration {

  init(_ element: ClassDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClassDeclaration(self)
  }
}

class ClosureExpressionProxy: PrimaryExpressionProxy,
 ClosureExpression {

  init(_ element: ClosureExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureExpression(self)
  }
}

class ClosureParameterProxy: ElementProxy, ClosureParameter {

  init(_ element: ClosureParameter) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureParameter(self)
  }
}

class ClosureParameterClauseProxy: ElementProxy, ClosureParameterClause {

  init(_ element: ClosureParameterClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureParameterClause(self)
  }
}

class ClosureParameterListProxy: ElementProxy, ClosureParameterList {

  init(_ element: ClosureParameterList) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureParameterList(self)
  }
}

class ClosureSignatureProxy: ElementProxy, ClosureSignature {

  init(_ element: ClosureSignature) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitClosureSignature(self)
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

class ConformanceRequirementProxy: RequirementProxy,
 ConformanceRequirement {

  init(_ element: ConformanceRequirement) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitConformanceRequirement(self)
  }
}

class DeclarationProxy: StatementProxy,
 Declaration {

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

class DefaultArgumentClauseProxy: ElementProxy, DefaultArgumentClause {

  init(_ element: DefaultArgumentClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDefaultArgumentClause(self)
  }
}

class DictionaryLiteralExpressionProxy: LiteralExpressionProxy,
 DictionaryLiteralExpression {

  init(_ element: DictionaryLiteralExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryLiteralExpression(self)
  }
}

class DictionaryLiteralItemProxy: ElementProxy, DictionaryLiteralItem {

  init(_ element: DictionaryLiteralItem) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryLiteralItem(self)
  }
}

class DictionaryLiteralItemsProxy: ElementProxy, DictionaryLiteralItems {

  init(_ element: DictionaryLiteralItems) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryLiteralItems(self)
  }
}

class DictionaryTypeProxy: TypeProxy,
 DictionaryType {

  init(_ element: DictionaryType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitDictionaryType(self)
  }
}

class ExplicitMemberExpressionProxy: PostfixExpressionProxy,
 ExplicitMemberExpression {

  init(_ element: ExplicitMemberExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitExplicitMemberExpression(self)
  }
}

class ExpressionProxy: StatementProxy,
 Expression {

  init(_ element: Expression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitExpression(self)
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

class ForcedValueExpressionProxy: PostfixExpressionProxy,
 ForcedValueExpression {

  init(_ element: ForcedValueExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitForcedValueExpression(self)
  }
}

class FunctionCallArgumentProxy: ElementProxy, FunctionCallArgument {

  init(_ element: FunctionCallArgument) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionCallArgument(self)
  }
}

class FunctionCallArgumentClauseProxy: ElementProxy, FunctionCallArgumentClause {

  init(_ element: FunctionCallArgumentClause) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionCallArgumentClause(self)
  }
}

class FunctionCallArgumentListProxy: ElementProxy, FunctionCallArgumentList {

  init(_ element: FunctionCallArgumentList) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionCallArgumentList(self)
  }
}

class FunctionCallExpressionProxy: PostfixExpressionProxy,
 FunctionCallExpression {

  init(_ element: FunctionCallExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitFunctionCallExpression(self)
  }
}

class FunctionDeclarationProxy: DeclarationProxy,
 FunctionDeclaration {

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

class FunctionTypeProxy: TypeProxy,
 FunctionType {

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

class IdentifierProxy: LeafNodeProxy,
 Identifier {

  init(_ element: Identifier) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifier(self)
  }
}

class IdentifierListProxy: ElementProxy, IdentifierList {

  init(_ element: IdentifierList) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifierList(self)
  }
}

class IdentifierPrimaryExpressionProxy: PrimaryExpressionProxy,
 IdentifierPrimaryExpression {

  init(_ element: IdentifierPrimaryExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitIdentifierPrimaryExpression(self)
  }
}

class ImplicitMemberExpressionProxy: PrimaryExpressionProxy,
 ImplicitMemberExpression {

  init(_ element: ImplicitMemberExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitImplicitMemberExpression(self)
  }
}

class InOutExpressionProxy: PrefixExpressionProxy,
 InOutExpression {

  init(_ element: InOutExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitInOutExpression(self)
  }
}

class InitializerDeclarationProxy: DeclarationProxy,
 InitializerDeclaration {

  init(_ element: InitializerDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitInitializerDeclaration(self)
  }
}

class InitializerExpressionProxy: PostfixExpressionProxy,
 InitializerExpression {

  init(_ element: InitializerExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitInitializerExpression(self)
  }
}

class KeyPathComponentProxy: ElementProxy, KeyPathComponent {

  init(_ element: KeyPathComponent) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathComponent(self)
  }
}

class KeyPathComponentsProxy: ElementProxy, KeyPathComponents {

  init(_ element: KeyPathComponents) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathComponents(self)
  }
}

class KeyPathExpressionProxy: PrimaryExpressionProxy,
 KeyPathExpression {

  init(_ element: KeyPathExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathExpression(self)
  }
}

class KeyPathPostfixProxy: ElementProxy, KeyPathPostfix {

  init(_ element: KeyPathPostfix) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathPostfix(self)
  }
}

class KeyPathPostfixesProxy: ElementProxy, KeyPathPostfixes {

  init(_ element: KeyPathPostfixes) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathPostfixes(self)
  }
}

class KeyPathStringExpressionProxy: PrimaryExpressionProxy,
 KeyPathStringExpression {

  init(_ element: KeyPathStringExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeyPathStringExpression(self)
  }
}

class KeywordLiteralExpressionProxy: LiteralExpressionProxy,
 KeywordLiteralExpression {

  init(_ element: KeywordLiteralExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitKeywordLiteralExpression(self)
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

class LiteralExpressionProxy: PrimaryExpressionProxy,
 LiteralExpression {

  init(_ element: LiteralExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitLiteralExpression(self)
  }
}

class MutationModifierProxy: DeclarationModifierProxy,
 MutationModifier {

  init(_ element: MutationModifier) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitMutationModifier(self)
  }
}

class OperatorPostfixExpressionProxy: PostfixExpressionProxy,
 OperatorPostfixExpression {

  init(_ element: OperatorPostfixExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitOperatorPostfixExpression(self)
  }
}

class OptionalChainingExpressionProxy: PostfixExpressionProxy,
 OptionalChainingExpression {

  init(_ element: OptionalChainingExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitOptionalChainingExpression(self)
  }
}

class OptionalTypeProxy: TypeProxy,
 OptionalType {

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

class ParenthesizedExpressionProxy: PrimaryExpressionProxy,
 ParenthesizedExpression {

  init(_ element: ParenthesizedExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitParenthesizedExpression(self)
  }
}

class PlaygroundLiteralArgumentProxy: ElementProxy, PlaygroundLiteralArgument {

  init(_ element: PlaygroundLiteralArgument) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPlaygroundLiteralArgument(self)
  }
}

class PlaygroundLiteralArgumentsProxy: ElementProxy, PlaygroundLiteralArguments {

  init(_ element: PlaygroundLiteralArguments) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPlaygroundLiteralArguments(self)
  }
}

class PlaygroundLiteralExpressionProxy: LiteralExpressionProxy,
 PlaygroundLiteralExpression {

  init(_ element: PlaygroundLiteralExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPlaygroundLiteralExpression(self)
  }
}

class PostfixExpressionProxy: ElementProxy, PostfixExpression {

  init(_ element: PostfixExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPostfixExpression(self)
  }
}

class PostfixSelfExpressionProxy: PostfixExpressionProxy,
 PostfixSelfExpression {

  init(_ element: PostfixSelfExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPostfixSelfExpression(self)
  }
}

class PrefixExpressionProxy: ElementProxy, PrefixExpression {

  init(_ element: PrefixExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPrefixExpression(self)
  }
}

class PrimaryExpressionProxy: PostfixExpressionProxy,
 PrimaryExpression {

  init(_ element: PrimaryExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitPrimaryExpression(self)
  }
}

class ProtocolCompositionTypeProxy: TypeProxy,
 ProtocolCompositionType {

  init(_ element: ProtocolCompositionType) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitProtocolCompositionType(self)
  }
}

class ProtocolDeclarationProxy: DeclarationProxy,
 ProtocolDeclaration {

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

class SameTypeRequirementProxy: RequirementProxy,
 SameTypeRequirement {

  init(_ element: SameTypeRequirement) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSameTypeRequirement(self)
  }
}

class SelectorExpressionProxy: PrimaryExpressionProxy,
 SelectorExpression {

  init(_ element: SelectorExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelectorExpression(self)
  }
}

class SelfExpressionProxy: PrimaryExpressionProxy,
 SelfExpression {

  init(_ element: SelfExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelfExpression(self)
  }
}

class SelfInitializerExpressionProxy: SelfExpressionProxy,
 SelfInitializerExpression {

  init(_ element: SelfInitializerExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelfInitializerExpression(self)
  }
}

class SelfMethodExpressionProxy: SelfExpressionProxy,
 SelfMethodExpression {

  init(_ element: SelfMethodExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelfMethodExpression(self)
  }
}

class SelfSubscriptExpressionProxy: SelfExpressionProxy,
 SelfSubscriptExpression {

  init(_ element: SelfSubscriptExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSelfSubscriptExpression(self)
  }
}

class StatementProxy: ElementProxy, Statement {

  init(_ element: Statement) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitStatement(self)
  }
}

class SubscriptDeclarationProxy: DeclarationProxy,
 SubscriptDeclaration {

  init(_ element: SubscriptDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSubscriptDeclaration(self)
  }
}

class SubscriptExpressionProxy: PostfixExpressionProxy,
 SubscriptExpression {

  init(_ element: SubscriptExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSubscriptExpression(self)
  }
}

class SuperclassExpressionProxy: PrimaryExpressionProxy,
 SuperclassExpression {

  init(_ element: SuperclassExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSuperclassExpression(self)
  }
}

class SuperclassInitializerExpressionProxy: SuperclassExpressionProxy,
 SuperclassInitializerExpression {

  init(_ element: SuperclassInitializerExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSuperclassInitializerExpression(self)
  }
}

class SuperclassMethodExpressionProxy: SuperclassExpressionProxy,
 SuperclassMethodExpression {

  init(_ element: SuperclassMethodExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSuperclassMethodExpression(self)
  }
}

class SuperclassSubscriptExpressionProxy: SuperclassExpressionProxy,
 SuperclassSubscriptExpression {

  init(_ element: SuperclassSubscriptExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitSuperclassSubscriptExpression(self)
  }
}

class TryOperatorProxy: ElementProxy, TryOperator {

  init(_ element: TryOperator) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTryOperator(self)
  }
}

class TupleElementProxy: ElementProxy, TupleElement {

  init(_ element: TupleElement) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleElement(self)
  }
}

class TupleElementListProxy: ElementProxy, TupleElementList {

  init(_ element: TupleElementList) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleElementList(self)
  }
}

class TupleExpressionProxy: PrimaryExpressionProxy,
 TupleExpression {

  init(_ element: TupleExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTupleExpression(self)
  }
}

class TupleTypeProxy: TypeProxy,
 TupleType {

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

class TypeCastingOperatorProxy: ElementProxy, TypeCastingOperator {

  init(_ element: TypeCastingOperator) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeCastingOperator(self)
  }
}

class TypeDeclarationProxy: DeclarationProxy,
 TypeDeclaration {

  init(_ element: TypeDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypeDeclaration(self)
  }
}

class TypeIdentifierProxy: TypeProxy,
 TypeIdentifier {

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

class TypealiasDeclarationProxy: DeclarationProxy,
 TypealiasDeclaration {

  init(_ element: TypealiasDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitTypealiasDeclaration(self)
  }
}

class VariableDeclarationProxy: DeclarationProxy,
 VariableDeclaration {

  init(_ element: VariableDeclaration) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitVariableDeclaration(self)
  }
}

class WhitespaceProxy: LeafNodeProxy,
 Whitespace {

  init(_ element: Whitespace) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitWhitespace(self)
  }
}

class WildcardExpressionProxy: PrimaryExpressionProxy,
 WildcardExpression {

  init(_ element: WildcardExpression) {
    super.init(element)
  }

  override func accept(_ visitor: ElementVisitor) {
    visitor.visitWildcardExpression(self)
  }
}
