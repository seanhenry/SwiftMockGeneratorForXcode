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

  open func visitCodeBlock(_ element: CodeBlock) {
    visitElement(element)
  }

  open func visitConformanceRequirement(_ element: ConformanceRequirement) {
    visitRequirement(element)
  }

  open func visitDeclaration(_ element: Declaration) {
    visitElement(element)
  }

  open func visitDeclarationModifier(_ element: DeclarationModifier) {
    visitElement(element)
  }

  open func visitDictionaryType(_ element: DictionaryType) {
    visitType(element)
  }

  open func visitFile(_ element: File) {
    visitElement(element)
  }

  open func visitFunctionDeclaration(_ element: FunctionDeclaration) {
    visitElement(element)
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

  open func visitInitializerDeclaration(_ element: InitializerDeclaration) {
    visitElement(element)
  }

  open func visitLeafNode(_ element: LeafNode) {
    visitElement(element)
  }

  open func visitMutationModifier(_ element: MutationModifier) {
    visitDeclarationModifier(element)
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

  open func visitProtocolCompositionType(_ element: ProtocolCompositionType) {
    visitType(element)
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

  open func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
    visitElement(element)
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

  open func visitTypeDeclaration(_ element: TypeDeclaration) {
    visitElement(element)
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
    visitElement(element)
  }

  open func visitVariableDeclaration(_ element: VariableDeclaration) {
    visitDeclaration(element)
  }

  open func visitWhitespace(_ element: Whitespace) {
    visitLeafNode(element)
  }
}
