class TypealiasImpl: ElementImpl, Typealias {

    static let errorTypealias = TypealiasImpl(text: "", children: [], offset: -1, length: -1, name: "", typealiasAssignment: TypealiasAssignmentImpl.errorTypealiasAssignment)
    let typealiasAssignment: TypealiasAssignment
    let name: String

    init(text: String, children: [Element], offset: Int64, length: Int64, name: String, typealiasAssignment: TypealiasAssignment) {
        self.name = name
        self.typealiasAssignment = typealiasAssignment
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypealias(self)
    }
}
