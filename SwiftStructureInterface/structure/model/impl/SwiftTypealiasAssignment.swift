class SwiftTypealiasAssignment: ElementImpl, TypealiasAssignment {

    static let errorTypealiasAssignment = SwiftTypealiasAssignment(text: "", children: [], offset: -1, length: -1, type: SwiftType.errorType)
    let type: Type

    init(text: String, children: [Element], offset: Int64, length: Int64, type: Type) {
        self.type = type
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypealiasAssignment(self)
    }
}
