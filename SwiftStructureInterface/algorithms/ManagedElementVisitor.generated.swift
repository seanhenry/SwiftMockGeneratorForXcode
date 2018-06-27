// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

class ManagedElementVisitor: ElementVisitor {

  static func wrap(_ element: Element) -> Element {
    let visitor = ManagedElementVisitor()
    element.accept(visitor)
    return visitor.wrapped
  }

  var wrapped: Element!

  override func visitElement(_ element: Element) {
    wrapped = ElementWrapper(element)
  }

  override func visitAccessLevelModifier(_ element: AccessLevelModifier) {
    wrapped = AccessLevelModifierWrapper(element)
  }

  override func visitArrayType(_ element: ArrayType) {
    wrapped = ArrayTypeWrapper(element)
  }

  override func visitAssociatedTypeDeclaration(_ element: AssociatedTypeDeclaration) {
    wrapped = AssociatedTypeDeclarationWrapper(element)
  }

  override func visitAttribute(_ element: Attribute) {
    wrapped = AttributeWrapper(element)
  }

  override func visitAttributes(_ element: Attributes) {
    wrapped = AttributesWrapper(element)
  }

  override func visitCodeBlock(_ element: CodeBlock) {
    wrapped = CodeBlockWrapper(element)
  }

  override func visitConformanceRequirement(_ element: ConformanceRequirement) {
    wrapped = ConformanceRequirementWrapper(element)
  }

  override func visitDeclaration(_ element: Declaration) {
    wrapped = DeclarationWrapper(element)
  }

  override func visitDeclarationModifier(_ element: DeclarationModifier) {
    wrapped = DeclarationModifierWrapper(element)
  }

  override func visitDictionaryType(_ element: DictionaryType) {
    wrapped = DictionaryTypeWrapper(element)
  }

  override func visitFile(_ element: File) {
    wrapped = FileWrapper(element)
  }

  override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
    wrapped = FunctionDeclarationWrapper(element)
  }

  override func visitFunctionResult(_ element: FunctionResult) {
    wrapped = FunctionResultWrapper(element)
  }

  override func visitFunctionType(_ element: FunctionType) {
    wrapped = FunctionTypeWrapper(element)
  }

  override func visitGenericArgumentClause(_ element: GenericArgumentClause) {
    wrapped = GenericArgumentClauseWrapper(element)
  }

  override func visitGenericParameter(_ element: GenericParameter) {
    wrapped = GenericParameterWrapper(element)
  }

  override func visitGenericParameterClause(_ element: GenericParameterClause) {
    wrapped = GenericParameterClauseWrapper(element)
  }

  override func visitGenericWhereClause(_ element: GenericWhereClause) {
    wrapped = GenericWhereClauseWrapper(element)
  }

  override func visitGetterSetterKeywordBlock(_ element: GetterSetterKeywordBlock) {
    wrapped = GetterSetterKeywordBlockWrapper(element)
  }

  override func visitGetterSetterKeywordClause(_ element: GetterSetterKeywordClause) {
    wrapped = GetterSetterKeywordClauseWrapper(element)
  }

  override func visitIdentifier(_ element: Identifier) {
    wrapped = IdentifierWrapper(element)
  }

  override func visitInitializerDeclaration(_ element: InitializerDeclaration) {
    wrapped = InitializerDeclarationWrapper(element)
  }

  override func visitLeafNode(_ element: LeafNode) {
    wrapped = LeafNodeWrapper(element)
  }

  override func visitMutationModifier(_ element: MutationModifier) {
    wrapped = MutationModifierWrapper(element)
  }

  override func visitOptionalType(_ element: OptionalType) {
    wrapped = OptionalTypeWrapper(element)
  }

  override func visitParameter(_ element: Parameter) {
    wrapped = ParameterWrapper(element)
  }

  override func visitParameterClause(_ element: ParameterClause) {
    wrapped = ParameterClauseWrapper(element)
  }

  override func visitProtocolCompositionType(_ element: ProtocolCompositionType) {
    wrapped = ProtocolCompositionTypeWrapper(element)
  }

  override func visitRequirement(_ element: Requirement) {
    wrapped = RequirementWrapper(element)
  }

  override func visitRequirementList(_ element: RequirementList) {
    wrapped = RequirementListWrapper(element)
  }

  override func visitSameTypeRequirement(_ element: SameTypeRequirement) {
    wrapped = SameTypeRequirementWrapper(element)
  }

  override func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
    wrapped = SubscriptDeclarationWrapper(element)
  }

  override func visitTupleType(_ element: TupleType) {
    wrapped = TupleTypeWrapper(element)
  }

  override func visitTupleTypeElement(_ element: TupleTypeElement) {
    wrapped = TupleTypeElementWrapper(element)
  }

  override func visitTupleTypeElementList(_ element: TupleTypeElementList) {
    wrapped = TupleTypeElementListWrapper(element)
  }

  override func visitType(_ element: Type) {
    wrapped = TypeWrapper(element)
  }

  override func visitTypeAnnotation(_ element: TypeAnnotation) {
    wrapped = TypeAnnotationWrapper(element)
  }

  override func visitTypeDeclaration(_ element: TypeDeclaration) {
    wrapped = TypeDeclarationWrapper(element)
  }

  override func visitTypeIdentifier(_ element: TypeIdentifier) {
    wrapped = TypeIdentifierWrapper(element)
  }

  override func visitTypeInheritanceClause(_ element: TypeInheritanceClause) {
    wrapped = TypeInheritanceClauseWrapper(element)
  }

  override func visitTypealiasAssignment(_ element: TypealiasAssignment) {
    wrapped = TypealiasAssignmentWrapper(element)
  }

  override func visitTypealiasDeclaration(_ element: TypealiasDeclaration) {
    wrapped = TypealiasDeclarationWrapper(element)
  }

  override func visitVariableDeclaration(_ element: VariableDeclaration) {
    wrapped = VariableDeclarationWrapper(element)
  }

  override func visitWhitespace(_ element: Whitespace) {
    wrapped = WhitespaceWrapper(element)
  }
}
