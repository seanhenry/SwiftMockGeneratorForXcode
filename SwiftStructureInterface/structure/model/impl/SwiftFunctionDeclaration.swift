class SwiftFunctionDeclaration: ElementImpl, FunctionDeclaration {

    static let errorFunctionDeclaration = SwiftFunctionDeclaration(name: "", text: "", children: [], offset: -1, length: -1, returnType: nil, parameters: [])
    let name: String
    let genericParameterClause: GenericParameterClause?
    let parameters: [Parameter]
    let returnType: Element?
    let `throws`: Bool

    convenience init(name: String, text: String, children: [Element], offset: Int64, length: Int64, returnType: Element?, parameters: [Parameter]) {
        self.init(name: name, text: text, children: children, offset: offset, length: length, returnType: returnType, genericParameterClause: nil, parameters: parameters, throws: false)
    }

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64, returnType: Element?, genericParameterClause: GenericParameterClause?, parameters: [Parameter], throws: Bool) {
        self.genericParameterClause = genericParameterClause
        self.name = name
        self.returnType = returnType
        self.parameters = parameters
        self.throws = `throws`
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitFunctionDeclaration(self)
    }
}
