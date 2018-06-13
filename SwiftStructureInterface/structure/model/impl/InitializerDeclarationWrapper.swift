class InitializerDeclarationWrapper: ElementWrapper, InitialiserDeclaration {

    let managedInitializerDeclaration: InitialiserDeclaration

    init(_ element: InitialiserDeclaration) {
        managedInitializerDeclaration = element
        super.init(element)
    }

    var parameters: [Parameter] {
        return managedInitializerDeclaration.parameters.map(wrap)
    }

    var `throws`: Bool {
        return managedInitializerDeclaration.`throws`
    }

    var `rethrows`: Bool {
        return managedInitializerDeclaration.`rethrows`
    }

    var isFailable: Bool {
        return managedInitializerDeclaration.isFailable
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitInitialiserDeclaration(self)
    }
}
