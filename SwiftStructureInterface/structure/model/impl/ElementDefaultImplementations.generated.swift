// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension AccessLevelModifier {

}
extension ArrayLiteralExpression {

  public var arrayLiteralItems: ArrayLiteralItems {
    return first(ArrayLiteralItems.self) ?? ArrayLiteralItemsImpl.emptyArrayLiteralItems()
  }
}
extension ArrayLiteralItem {

  public var expression: Expression {
    return first(Expression.self) ?? ExpressionImpl.emptyExpression()
  }
}
extension ArrayLiteralItems {

  public var items: [ArrayLiteralItem] {
    return children.compactMap { $0 as? ArrayLiteralItem }
  }
}
extension ArrayType {

  public var elementType: Type {
    return first(Type.self) ?? TypeImpl.emptyType()
  }
}
extension AssociatedTypeDeclaration {

  public var typeInheritanceClause: [Element] {
    return children.compactMap { $0 as? Element }
  }
  public var typealiasAssignment: TypealiasAssignment? {
    return first(TypealiasAssignment.self)
  }
  public var genericWhereClause: GenericWhereClause? {
    return first(GenericWhereClause.self)
  }
}
extension Attribute {

}
extension Attributes {

  public var attributes: [Attribute] {
    return children.compactMap { $0 as? Attribute }
  }
}
extension CaptureList {

  public var captureListItems: CaptureListItems {
    return first(CaptureListItems.self) ?? CaptureListItemsImpl.emptyCaptureListItems()
  }
}
extension CaptureListItem {

  public var expression: Expression {
    return first(Expression.self) ?? ExpressionImpl.emptyExpression()
  }
}
extension CaptureListItems {

  public var items: [CaptureListItem] {
    return children.compactMap { $0 as? CaptureListItem }
  }
}
extension ClassDeclaration {

  public var genericParameterClause: GenericParameterClause {
    return first(GenericParameterClause.self) ?? GenericParameterClauseImpl.emptyGenericParameterClause()
  }
}
extension ClosureExpression {

  public var closureSignature: ClosureSignature? {
    return first(ClosureSignature.self)
  }
  public var statements: [Element] {
    return children.compactMap { $0 as? Element }
  }
}
extension ClosureParameter {

  public var typeAnnotation: TypeAnnotation? {
    return first(TypeAnnotation.self)
  }
}
extension ClosureParameterClause {

  public var closureParameterList: ClosureParameterList? {
    return first(ClosureParameterList.self)
  }
  public var identifierList: IdentifierList? {
    return first(IdentifierList.self)
  }
}
extension ClosureParameterList {

  public var closureParameters: [ClosureParameter] {
    return children.compactMap { $0 as? ClosureParameter }
  }
}
extension ClosureSignature {

  public var captureList: CaptureList? {
    return first(CaptureList.self)
  }
  public var closureParameterClause: ClosureParameterClause {
    return first(ClosureParameterClause.self) ?? ClosureParameterClauseImpl.emptyClosureParameterClause()
  }
  public var functionResult: FunctionResult? {
    return first(FunctionResult.self)
  }
}
extension CodeBlock {

}
extension ConformanceRequirement {

  public var rightProtocolCompositionType: ProtocolCompositionType {
    return first(ProtocolCompositionType.self) ?? ProtocolCompositionTypeImpl.emptyProtocolCompositionType()
  }
}
extension Declaration {

  public var attributes: Attributes {
    return first(Attributes.self) ?? AttributesImpl.emptyAttributes()
  }
  public var accessLevelModifier: AccessLevelModifier {
    return first(AccessLevelModifier.self) ?? AccessLevelModifierImpl.emptyAccessLevelModifier()
  }
}
extension DeclarationModifier {

}
extension DictionaryLiteralExpression {

  public var dictionaryLiteralItems: DictionaryLiteralItems {
    return first(DictionaryLiteralItems.self) ?? DictionaryLiteralItemsImpl.emptyDictionaryLiteralItems()
  }
}
extension DictionaryLiteralItem {

  public var expression: Expression {
    return first(Expression.self) ?? ExpressionImpl.emptyExpression()
  }
}
extension DictionaryLiteralItems {

  public var items: [DictionaryLiteralItem] {
    return children.compactMap { $0 as? DictionaryLiteralItem }
  }
}
extension DictionaryType {

  public var keyType: Type {
    return first(Type.self) ?? TypeImpl.emptyType()
  }
}
extension Expression {

}
extension FunctionCallArgument {

}
extension FunctionCallArgumentList {

  public var arguments: [FunctionCallArgument] {
    return children.compactMap { $0 as? FunctionCallArgument }
  }
}
extension FunctionDeclaration {

  public var genericParameterClause: GenericParameterClause? {
    return first(GenericParameterClause.self)
  }
  public var parameterClause: ParameterClause {
    return first(ParameterClause.self) ?? ParameterClauseImpl.emptyParameterClause()
  }
  public var returnType: FunctionResult? {
    return first(FunctionResult.self)
  }
  public var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
}
extension FunctionResult {

  public var attributes: Attributes {
    return first(Attributes.self) ?? AttributesImpl.emptyAttributes()
  }
  public var type: Type {
    return first(Type.self) ?? TypeImpl.emptyType()
  }
}
extension FunctionType {

  public var attributes: Attributes {
    return first(Attributes.self) ?? AttributesImpl.emptyAttributes()
  }
  public var arguments: TupleType {
    return first(TupleType.self) ?? TupleTypeImpl.emptyTupleType()
  }
}
extension GenericArgumentClause {

  public var arguments: [Type] {
    return children.compactMap { $0 as? Type }
  }
}
extension GenericParameter {

  public var typeIdentifier: TypeIdentifier? {
    return first(TypeIdentifier.self)
  }
  public var protocolComposition: ProtocolCompositionType? {
    return first(ProtocolCompositionType.self)
  }
}
extension GenericParameterClause {

  public var parameters: [GenericParameter] {
    return children.compactMap { $0 as? GenericParameter }
  }
}
extension GenericWhereClause {

  public var requirementList: RequirementList {
    return first(RequirementList.self) ?? RequirementListImpl.emptyRequirementList()
  }
}
extension GetterSetterKeywordBlock {

}
extension GetterSetterKeywordClause {

  public var attributes: Attributes {
    return first(Attributes.self) ?? AttributesImpl.emptyAttributes()
  }
  public var mutationModifier: MutationModifier {
    return first(MutationModifier.self) ?? MutationModifierImpl.emptyMutationModifier()
  }
}
extension Identifier {

}
extension IdentifierList {

  public var identifiers: [Identifier] {
    return children.compactMap { $0 as? Identifier }
  }
}
extension IdentifierPrimaryExpression {

}
extension ImplicitMemberExpression {

}
extension InOutExpression {

  public var identifier: Identifier {
    return first(Identifier.self) ?? IdentifierImpl.emptyIdentifier()
  }
}
extension InitializerDeclaration {

  public var parameterClause: ParameterClause {
    return first(ParameterClause.self) ?? ParameterClauseImpl.emptyParameterClause()
  }
}
extension KeyPathComponent {

  public var identifier: Identifier? {
    return first(Identifier.self)
  }
  public var postfixes: KeyPathPostfixes? {
    return first(KeyPathPostfixes.self)
  }
}
extension KeyPathComponents {

  public var components: [KeyPathComponent] {
    return children.compactMap { $0 as? KeyPathComponent }
  }
}
extension KeyPathExpression {

  public var type: Identifier? {
    return first(Identifier.self)
  }
  public var components: KeyPathComponents {
    return first(KeyPathComponents.self) ?? KeyPathComponentsImpl.emptyKeyPathComponents()
  }
}
extension KeyPathPostfix {

}
extension KeyPathPostfixes {

  public var postfixes: [KeyPathPostfix] {
    return children.compactMap { $0 as? KeyPathPostfix }
  }
}
extension KeyPathStringExpression {

}
extension KeywordLiteralExpression {

}
extension LiteralExpression {

}
extension MutationModifier {

}
extension OptionalType {

  public var type: Type {
    return first(Type.self) ?? TypeImpl.emptyType()
  }
}
extension Parameter {

  public var typeAnnotation: TypeAnnotation {
    return first(TypeAnnotation.self) ?? TypeAnnotationImpl.emptyTypeAnnotation()
  }
}
extension ParameterClause {

  public var parameters: [Parameter] {
    return children.compactMap { $0 as? Parameter }
  }
}
extension ParenthesizedExpression {

}
extension PlaygroundLiteralArgument {

}
extension PlaygroundLiteralArguments {

  public var arguments: [PlaygroundLiteralArgument] {
    return children.compactMap { $0 as? PlaygroundLiteralArgument }
  }
}
extension PlaygroundLiteralExpression {

  public var playgroundLiteralArguments: PlaygroundLiteralArguments {
    return first(PlaygroundLiteralArguments.self) ?? PlaygroundLiteralArgumentsImpl.emptyPlaygroundLiteralArguments()
  }
}
extension PrefixExpression {

}
extension PrimaryExpression {

}
extension ProtocolCompositionType {

  public var types: [Type] {
    return children.compactMap { $0 as? Type }
  }
}
extension ProtocolDeclaration {

}
extension Requirement {

  public var leftTypeIdentifier: TypeIdentifier {
    return first(TypeIdentifier.self) ?? TypeIdentifierImpl.emptyTypeIdentifier()
  }
}
extension RequirementList {

  public var requirements: [Requirement] {
    return children.compactMap { $0 as? Requirement }
  }
}
extension SameTypeRequirement {

}
extension SelectorExpression {

}
extension SelfExpression {

}
extension SelfInitializerExpression {

}
extension SelfMethodExpression {

}
extension SelfSubscriptExpression {

}
extension SubscriptDeclaration {

  public var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
}
extension SuperclassExpression {

}
extension SuperclassInitializerExpression {

}
extension SuperclassMethodExpression {

}
extension SuperclassSubscriptExpression {

}
extension TupleType {

  public var tupleTypeElementList: TupleTypeElementList {
    return first(TupleTypeElementList.self) ?? TupleTypeElementListImpl.emptyTupleTypeElementList()
  }
}
extension TupleTypeElement {

  public var typeAnnotation: TypeAnnotation? {
    return first(TypeAnnotation.self)
  }
  public var type: Type? {
    return first(Type.self)
  }
}
extension TupleTypeElementList {

  public var tupleTypeElements: [TupleTypeElement] {
    return children.compactMap { $0 as? TupleTypeElement }
  }
}
extension Type {

}
extension TypeAnnotation {

  public var attributes: Attributes {
    return first(Attributes.self) ?? AttributesImpl.emptyAttributes()
  }
  public var type: Type {
    return first(Type.self) ?? TypeImpl.emptyType()
  }
}
extension TypeDeclaration {

  public var accessLevelModifier: AccessLevelModifier {
    return first(AccessLevelModifier.self) ?? AccessLevelModifierImpl.emptyAccessLevelModifier()
  }
  public var declarationModifiers: [DeclarationModifier] {
    return children.compactMap { $0 as? DeclarationModifier }
  }
  public var typeInheritanceClause: TypeInheritanceClause {
    return first(TypeInheritanceClause.self) ?? TypeInheritanceClauseImpl.emptyTypeInheritanceClause()
  }
  public var codeBlock: CodeBlock {
    return first(CodeBlock.self) ?? CodeBlockImpl.emptyCodeBlock()
  }
}
extension TypeIdentifier {

  public var parentType: TypeIdentifier? {
    return first(TypeIdentifier.self)
  }
  public var genericArgumentClause: GenericArgumentClause {
    return first(GenericArgumentClause.self) ?? GenericArgumentClauseImpl.emptyGenericArgumentClause()
  }
}
extension TypeInheritanceClause {

  public var inheritedTypes: [Type] {
    return children.compactMap { $0 as? Type }
  }
}
extension TypealiasAssignment {

  public var type: Type {
    return first(Type.self) ?? TypeImpl.emptyType()
  }
}
extension TypealiasDeclaration {

  public var typealiasAssignment: TypealiasAssignment {
    return first(TypealiasAssignment.self) ?? TypealiasAssignmentImpl.emptyTypealiasAssignment()
  }
}
extension VariableDeclaration {

  public var typeAnnotation: TypeAnnotation {
    return first(TypeAnnotation.self) ?? TypeAnnotationImpl.emptyTypeAnnotation()
  }
  public var getterSetterKeywordBlock: GetterSetterKeywordBlock {
    return first(GetterSetterKeywordBlock.self) ?? GetterSetterKeywordBlockImpl.emptyGetterSetterKeywordBlock()
  }
  public var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
}
extension Whitespace {

}
extension WildcardExpression {

}
