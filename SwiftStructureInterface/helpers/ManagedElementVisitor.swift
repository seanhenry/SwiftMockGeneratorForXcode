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

    override func visitTypeDeclaration(_ element: TypeDeclaration) {
        wrapped = TypeDeclarationWrapper(element)
    }

    override func visitFile(_ element: File) {
        wrapped = FileWrapper(element)
    }

    override func visitType(_ element: Type) {
        wrapped = TypeWrapper(element)
    }

    override func visitArrayType(_ element: ArrayType) {
        wrapped = ArrayTypeWrapper(element)
    }

    override func visitDictionaryType(_ element: DictionaryType) {
        wrapped = DictionaryTypeWrapper(element)
    }

    override func visitOptionalType(_ element: OptionalType) {
        wrapped = OptionalTypeWrapper(element)
    }

    override func visitTypeIdentifier(_ element: TypeIdentifier) {
        wrapped = TypeIdentifierWrapper(element)
    }

    override func visitTupleType(_ element: TupleType) {
        wrapped = TupleTypeWrapper(element)
    }

    override func visitTupleTypeElement(_ element: TupleTypeElement) {
        wrapped = TupleTypeElementWrapper(element)
    }

    override func visitTypeAnnotation(_ element: TypeAnnotation) {
        wrapped = TypeAnnotationWrapper(element)
    }

    override func visitFunctionType(_ element: FunctionType) {
        wrapped = FunctionTypeWrapper(element)
    }

    override func visitFunctionDeclaration(_ element: FunctionDeclaration) {
        wrapped = FunctionDeclarationWrapper(element)
    }

    override func visitVariableDeclaration(_ element: VariableDeclaration) {
        wrapped = VariableDeclarationWrapper(element)
    }

    override func visitGenericParameterClause(_ element: GenericParameterClause) {
        wrapped = GenericParameterClauseWrapper(element)
    }

    override func visitGenericParameter(_ element: GenericParameter) {
        wrapped = GenericParameterWrapper(element)
    }

    override func visitTypealias(_ element: Typealias) {
        wrapped = TypealiasWrapper(element)
    }

    override func visitTypealiasAssignment(_ element: TypealiasAssignment) {
        wrapped = TypealiasAssignmentWrapper(element)
    }

    override func visitParameter(_ element: Parameter) {
        wrapped = ParameterWrapper(element)
    }

    override func visitInitializerDeclaration(_ element: InitializerDeclaration) {
        wrapped = InitializerDeclarationWrapper(element)
    }

    override func visitSubscriptDeclaration(_ element: SubscriptDeclaration) {
        wrapped = SubscriptDeclarationWrapper(element)
    }

    override func visitAccessLevelModifier(_ element: AccessLevelModifier) {
        wrapped = AccessLevelModifierWrapper(element)
    }

    override func visitProtocolCompositionType(_ element: ProtocolCompositionType) {
        wrapped = ProtocolCompositionTypeWrapper(element)
    }

    override func visitGetterSetterKeywordBlock(_ element: GetterSetterKeywordBlock) {
        wrapped = GetterSetterKeywordBlockWrapper(element)
    }
}
