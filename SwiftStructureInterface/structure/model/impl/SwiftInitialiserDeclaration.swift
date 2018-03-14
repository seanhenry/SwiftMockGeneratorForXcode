class SwiftInitialiserDeclaration: SwiftElement, InitialiserDeclaration {
    static let errorInitialiser = SwiftInitialiserDeclaration(text: "", children: [], offset: -1, length: -1)

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitInitialiserDeclaration(self)
    }
}
