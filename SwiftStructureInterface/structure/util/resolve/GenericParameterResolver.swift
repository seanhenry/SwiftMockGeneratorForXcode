class GenericParameterResolver: ResolverDecorator {

    override func resolve(_ element: Element) -> Element? {
        return ElementTreeUtil().findParent(FunctionDeclaration.self, from: element)?
                .genericParameterClause?
                .parameters
                .first { $0.typeName == element.text }
        ?? super.resolve(element)
    }
}
