public protocol Declarations: Element {
}

public extension Declarations {

    public var variableDeclarations: [VariableDeclaration] {
        return filterChildren(VariableDeclaration.self)
    }

    public var initializerDeclarations: [InitializerDeclaration] {
        return filterChildren(InitializerDeclaration.self)
    }

    public var functionDeclarations: [FunctionDeclaration] {
        return filterChildren(FunctionDeclaration.self)
    }

    public var typeDeclarations: [TypeDeclaration] {
        return filterChildren(TypeDeclaration.self)
    }

    public var typealiasDeclarations: [TypealiasDeclaration] {
        return filterChildren(TypealiasDeclaration.self)
    }

    public var subscriptDeclarations: [SubscriptDeclaration] {
        return filterChildren(SubscriptDeclaration.self)
    }

    private func filterChildren<T>(_ type: T.Type) -> [T] {
        return children
            .compactMap { $0 as? T }
    }
}
