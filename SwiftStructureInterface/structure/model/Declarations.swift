public protocol Declarations: Element {
}

extension Declarations {

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

extension Declarations where Self: TypeDeclaration {

    public var variableDeclarations: [VariableDeclaration] {
        return codeBlock.variableDeclarations
    }

    public var initializerDeclarations: [InitializerDeclaration] {
        return codeBlock.initializerDeclarations
    }

    public var functionDeclarations: [FunctionDeclaration] {
        return codeBlock.functionDeclarations
    }

    public var typeDeclarations: [TypeDeclaration] {
        return codeBlock.typeDeclarations
    }

    public var typealiasDeclarations: [TypealiasDeclaration] {
        return codeBlock.typealiasDeclarations
    }

    public var subscriptDeclarations: [SubscriptDeclaration] {
        return codeBlock.subscriptDeclarations
    }
}
