// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension AccessLevelModifier {

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
extension ClassDeclaration {

  public var genericParameterClause: GenericParameterClause {
    return first(GenericParameterClause.self) ?? GenericParameterClauseImpl.emptyGenericParameterClause()
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
extension DictionaryType {

  public var keyType: Type {
    return first(Type.self) ?? TypeImpl.emptyType()
  }
}
extension Expression {

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
extension IdentifierPrimaryExpression {

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
extension SelfExpression {

}
extension SelfInitializerExpression {

}
extension SelfMethodExpression {

}
extension SubscriptDeclaration {

  public var declarations: [Element] {
    return children.compactMap { $0 as? Element }
  }
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
