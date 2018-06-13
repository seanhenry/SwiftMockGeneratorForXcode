public protocol Declarations: Element {
}

public extension Declarations {

    var variableDeclarations: [VariableDeclaration] {
        return filterChildren(VariableDeclaration.self)
    }

    var initializerDeclarations: [InitializerDeclaration] {
        return filterChildren(InitializerDeclaration.self)
    }

    var functionDeclarations: [FunctionDeclaration] {
        return filterChildren(FunctionDeclaration.self)
    }

    var typeDeclarations: [TypeDeclaration] {
        return filterChildren(TypeDeclaration.self)
    }

    var typealiasDeclarations: [Typealias] {
        return filterChildren(Typealias.self)
    }

    var subscriptDeclarations: [SubscriptDeclaration] {
        return filterChildren(SubscriptDeclaration.self)
    }

    private func filterChildren<T>(_ type: T.Type) -> [T] {
        return children
            .compactMap { $0 as? T }
    }
}
