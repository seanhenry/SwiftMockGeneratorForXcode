class SwiftGenericParameterClause: SwiftElement, GenericParameterClause {
    static let errorGenericParameterClause = SwiftGenericParameterClause(text: "", children: [], offset: -1, length: -1)

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitGenericParameterClause(self)
    }
}
