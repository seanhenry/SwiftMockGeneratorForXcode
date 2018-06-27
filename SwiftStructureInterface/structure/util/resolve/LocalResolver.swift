class LocalResolver: ResolverDecorator {

    override func resolve(_ element: Element) -> Element? {
        return resolveGenericParameter(element)
                ?? resolveTypealias(element)
                ?? super.resolve(element)
    }

    private func resolveGenericParameter(_ element: Element) -> Element? {
        return ElementTreeUtil().findParent(FunctionDeclaration.self, from: element)?
                .genericParameterClause?
                .parameters
                .first { $0.name == element.text }
    }

    private func resolveTypealias(_ element: Element) -> Element? {
        return ElementTreeUtil().findParent(TypeDeclaration.self, from: element)?
                .codeBlock
                .typealiasDeclarations
                .first { $0.name == element.text }
    }
}
