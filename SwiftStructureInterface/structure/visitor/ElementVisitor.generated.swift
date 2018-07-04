// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

open class ElementVisitor {

  public init() {
  }

  open func visitElement(_ element: Element) {

  }

  open func visitAccessLevelModifier(_ element: AccessLevelModifier) {
    visitDeclarationModifier(element)
  }

  open func visitArgumentName(_ element: ArgumentName) {
    visitElement(element)
  }

  open func visitArgumentNames(_ element: ArgumentNames) {
    visitElement(element)
  }

  open func visitArrayLiteralExpression(_ element: ArrayLiteralExpression) {
    visitLiteralExpression(element)
  }

  open func visitArrayLiteralItem(_ element: ArrayLiteralItem) {
    visitElement(element)
  }

  open func visitArrayLiteralItems(_ element: ArrayLiteralItems) {
    visitElement(element)
  }

  open func visitArrayType(_ element: ArrayType) {
    visitType(element)
  }

  open func visitAssociatedTypeDeclaration(_ element: AssociatedTypeDeclaration) {
    visitDeclaration(element)
  }

  open func visitAttribute(_ element: Attribute) {
    visitElement(element)
  }

  open func visitAttributes(_ element: Attributes) {
    visitElement(element)
  }

  open func visitBinaryExpression(_ element: BinaryExpression) {
    visitElement(element)
  }

  open func visitCaptureList(_ element: CaptureList) {
    visitElement(element)
  }

  open func visitCaptureListItem(_ element: CaptureListItem) {
    visitElement(element)
  }

  open func visitCaptureListItems(_ element: CaptureListItems) {
    visitElement(element)
  }

  open func visitClassDeclaration(_ element: ClassDeclaration) {
    visitTypeDeclaration(element)
  }

  open func visitClosureExpression(_ element: ClosureExpression) {
    visitPrimaryExpression(element)
  }

  open func visitClosureParameter(_ element: ClosureParameter) {
    visitElement(element)
  }

  open func visitClosureParameterClause(_ element: ClosureParameterClause) {
    visitElement(element)
  }

  open func visitClosureParameterList(_ element: ClosureParameterList) {
    visitElement(element)
  }

  open func visitClosureSignature(_ element: ClosureSignature) {
    visitElement(element)
  }

  open func visitCodeBlock(_ element: CodeBlock) {
    visitElement(element)
  }

  open func visitConditionalOperator(_ element: ConditionalOperator) {
    visitElement(element)
  }

  open func visitConformanceRequirement(_ element: ConformanceRequirement) {
    visitRequirement(element)
  }

  open func visitDeclaration(_ element: Declaration) {
    visitStatement(element)
  }

  open func visitDeclarationModifier(_ element: DeclarationModifier) {
    visitElement(element)
  }

  open func visitDefaultArgumentClause(_ element: DefaultArgumentClause) {
    visitElement(element)
  }

  open func visitDictionaryLiteralExpression(_ element: DictionaryLiteralExpression) {
    visitLiteralExpression(element)
  }

  open func visitDictionaryLiteralItem(_ element: DictionaryLiteralItem) {
    visitElement(element)
  }

  open func visitDictionaryLiteralItems(_ element: DictionaryLiteralItems) {
    visitElement(element)
  }

  open func visitDictionaryType(_ element: DictionaryType) {
    visitType(element)
  }

  open func visitExplicitMemberExpression(_ element: ExplicitMemberExpression) {
    visitPostfixExpression(element)
  }

  open func visitExpression(_ element: Expression) {
    visitStatement(element)
  }

  open func visitFile(_ element: File) {
    visitElement(element)
  }

  open func visitForcedValueExpression(_ element: ForcedValueExpression) {
    visitPostfixExpression(element)
  }

  open func visitFunctionCallArgument(_ element: FunctionCallArgument) {
    visitElement(element)
  }

  open func visitFunctionCallArgumentClause(_ element: FunctionCallArgumentClause) {
    visitElement(element)
  }

  open func visitFunctionCallArgumentList(_ element: FunctionCallArgumentList) {
    visitElement(element)
  }

  open func visitFunctionCallExpression(_ element: FunctionCallExpression) {
    visitPostfixExpression(element)
  }

  open func visitFunctionDeclaration(_ element: FunctionDeclaration) {
    visitDeclaration(element)
  }

  open func visitFunctionResult(_ element: FunctionResult) {
    visitElement(element)
  }

  open func visitFunctionType(_ element: FunctionType) {
    visitType(element)
  }

  open func visitGenericArgumentClause(_ element: GenericArgumentClause) {
    visitElement(element)
  }

  open func visitGenericParameter(_ element: GenericParameter) {
    visitElement(element)
  }

  open func visitGenericParameterClause(_ element: GenericParameterClause) {
    visitElement(element)
  }

  open func visitGenericWhereClause(_ element: GenericWhereClause) {
    visitElement(element)
  }

  open func visitGetterSetterKeywordBlock(_ element: GetterSetterKeywordBlock) {
    visitElement(element)
  }

  open func visitGetterSetterKeywordClause(_ element: GetterSetterKeywordClause) {
    visitElement(element)
  }

  open func visitIdentifier(_ element: Identifier) {
    visitLeafNode(element)
  }

  open func visitIdentifierList(_ element: IdentifierList) {
    visitElement(element)
  }

  open func visitIdentifierPrimaryExpression(_ element: IdentifierPrimaryExpression) {
    visitPrimaryExpression(element)
  }

  open func visitImplicitMemberExpression(_ element: ImplicitMemberExpression) {
    visitPrimaryExpression(element)
  }

  open func visitInOutExpression(_ element: InOutExpression) {
    visitPrefixExpression(element)
  }

  open func visitInitializerDeclaration(_ element: InitializerDeclaration) {
    visitDeclaration(element)
  }

  open func visitInitializerExpression(_ element: InitializerExpression) {
    visitPostfixExpression(element)
  }

  open func visitKeyPathComponent(_ element: KeyPathComponent) {
    visitElement(element)
  }

  open func visitKeyPathComponents(_ element: KeyPathComponents) {
    visitElement(element)
  }

  open func visitKeyPathExpression(_ element: KeyPathExpression) {
    visitPrimaryExpression(element)
  }

  open func visitKeyPathPostfix(_ element: KeyPathPostfix) {
    visitElement(element)
  }

  open func visitKeyPathPostfixes(_ element: KeyPathPostfixes) {
    visitElement(element)
  }

  open func visitKeyPathStringExpression(_ element: KeyPathStringExpression) {
    visitPrimaryExpression(element)
  }

  open func visitKeywordLiteralExpression(_ element: KeywordLiteralExpression) {
    visitLiteralExpression(element)
  }

  open func visitLeafNode(_ element: LeafNode) {
    visitElement(element)
  }

  open func visitLiteralExpression(_ element: LiteralExpression) {
    visitPrimaryExpression(element)
  }

  open func visitMutationModifier(_ element: MutationModifier) {
    visitDeclarationModifier(element)
  }

  open func visitOperatorPostfixExpression(_ element: OperatorPostfixExpression) {
    visitPostfixExpression(element)
  }

  open func visitOptionalChainingExpression(_ element: OptionalChainingExpression) {
    visitPostfixExpression(element)
  }

  open func visitOptionalType(_ element: OptionalType) {
    visitType(element)
  }

  open func visitParameter(_ element: Parameter) {
    visitElement(element)
  }

  open func visitParameterClause(_ element: ParameterClause) {
    visitElement(element)
  }

  open func visitParenthesizedExpression(_ element: ParenthesizedExpression) {
    visitPrimaryExpression(element)
  }

  open func visitPlaygroundLiteralArgument(_ element: PlaygroundLiteralArgument) {
    visitElement(element)
  }

  open func visitPlaygroundLiteralArguments(_ element: PlaygroundLiteralArguments) {
    visitElement(element)
  }

  open func visitPlaygroundLiteralExpression(_ element: PlaygroundLiteralExpression) {
    visitLiteralExpression(element)
  }

  open func visitPostfixExpression(_ element: PostfixExpression) {
    visitElement(element)
  }

  open func visitPostfixSelfExpression(_ element: PostfixSelfExpression) {
    visitPostfixExpression(element)
  }

  open func visitPrefixExpression(_ element: PrefixExpression) {
    visitElement(element)
  }

  open func visitPrimaryExpression(_ element: PrimaryExpression) {
    visitPostfixExpression(element)
  }

  open func visitProtocolCompositionType(_ element: ProtocolCompositionType) {
    visitType(element)
  }

  open func visitProtocolDeclaration(_ element: ProtocolDeclaration) {
    visitTypeDeclaration(element)
  }

  open func visitRequirement(_ element: Requirement) {
    visitElement(element)
  }

  open func visitRequirementList(_ element: RequirementList) {
    visitElement(element)
  }

  open func visitSameTypeRequirement(_ element: SameTypeRequirement) {
    visitRequirement(element)
  }

  open func visitSelectorExpression(_ element: SelectorExpression) {
    visitPrimaryExpression(element)
  }

  open func visitSelfExpression(_ element: SelfExpression) {
    visitPrimaryExpression(element)
  }

  open func visitSelfInitializerExpression(_ element: SelfInitializerExpression) {
    visitSelfExpression(element)
  }

  open func visitSelfMethodExpression(_ element: SelfMethodExpression) {
    visitSelfExpression(element)
  }

  open func visitSelfSubscriptExpression(_ element: SelfSubscriptExpression) {
    visitSelfExpression(element)
  }

  open func visitStatement(_ element: Statement) {
    visitElement(element)
  }

  open func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
    visitDeclaration(element)
  }

  open func visitSubscriptExpression(_ element: SubscriptExpression) {
    visitPostfixExpression(element)
  }

  open func visitSuperclassExpression(_ element: SuperclassExpression) {
    visitPrimaryExpression(element)
  }

  open func visitSuperclassInitializerExpression(_ element: SuperclassInitializerExpression) {
    visitSuperclassExpression(element)
  }

  open func visitSuperclassMethodExpression(_ element: SuperclassMethodExpression) {
    visitSuperclassExpression(element)
  }

  open func visitSuperclassSubscriptExpression(_ element: SuperclassSubscriptExpression) {
    visitSuperclassExpression(element)
  }

  open func visitTryOperator(_ element: TryOperator) {
    visitElement(element)
  }

  open func visitTupleElement(_ element: TupleElement) {
    visitElement(element)
  }

  open func visitTupleElementList(_ element: TupleElementList) {
    visitElement(element)
  }

  open func visitTupleExpression(_ element: TupleExpression) {
    visitPrimaryExpression(element)
  }

  open func visitTupleType(_ element: TupleType) {
    visitType(element)
  }

  open func visitTupleTypeElement(_ element: TupleTypeElement) {
    visitElement(element)
  }

  open func visitTupleTypeElementList(_ element: TupleTypeElementList) {
    visitElement(element)
  }

  open func visitType(_ element: Type) {
    visitElement(element)
  }

  open func visitTypeAnnotation(_ element: TypeAnnotation) {
    visitElement(element)
  }

  open func visitTypeCastingOperator(_ element: TypeCastingOperator) {
    visitElement(element)
  }

  open func visitTypeDeclaration(_ element: TypeDeclaration) {
    visitDeclaration(element)
  }

  open func visitTypeIdentifier(_ element: TypeIdentifier) {
    visitType(element)
  }

  open func visitTypeInheritanceClause(_ element: TypeInheritanceClause) {
    visitElement(element)
  }

  open func visitTypealiasAssignment(_ element: TypealiasAssignment) {
    visitElement(element)
  }

  open func visitTypealiasDeclaration(_ element: TypealiasDeclaration) {
    visitDeclaration(element)
  }

  open func visitVariableDeclaration(_ element: VariableDeclaration) {
    visitDeclaration(element)
  }

  open func visitWhitespace(_ element: Whitespace) {
    visitLeafNode(element)
  }

  open func visitWildcardExpression(_ element: WildcardExpression) {
    visitPrimaryExpression(element)
  }
}
