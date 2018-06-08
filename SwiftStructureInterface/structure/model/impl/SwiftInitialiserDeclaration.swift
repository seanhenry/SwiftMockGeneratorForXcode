class SwiftInitialiserDeclaration: ElementImpl, InitialiserDeclaration {

    static let errorInitialiserDeclaration = SwiftInitialiserDeclaration(text: "", children: [], offset: -1, length: -1, parameters: [], throws: false, rethrows: false, isFailable: false)

    let parameters: [Parameter]
    let `throws`: Bool
    let `rethrows`: Bool
    let isFailable: Bool

    init(text: String, children: [Element], offset: Int64, length: Int64, parameters: [Parameter], `throws`: Bool, `rethrows`: Bool, isFailable: Bool) {
        self.parameters = parameters
        self.throws = `throws`
        self.rethrows = `rethrows`
        self.isFailable = isFailable
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitInitialiserDeclaration(self)
    }
}
