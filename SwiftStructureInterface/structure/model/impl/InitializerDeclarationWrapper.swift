class InitializerDeclarationWrapper<T: InitialiserDeclaration>: ElementWrapper<T>, InitialiserDeclaration {

    var parameters: [Parameter] {
        return managed.parameters
    }

    var `throws`: Bool {
        return managed.`throws`
    }

    var `rethrows`: Bool {
        return managed.`rethrows`
    }

    var isFailable: Bool {
        return managed.isFailable
    }
}
