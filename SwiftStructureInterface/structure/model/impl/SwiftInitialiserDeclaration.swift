class SwiftInitialiserDeclaration: SwiftElement, InitialiserDeclaration {
    static let errorInitialiserDeclaration = SwiftInitialiserDeclaration(text: "", children: [], offset: -1, length: -1)

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitInitialiserDeclaration(self)
    }
}
