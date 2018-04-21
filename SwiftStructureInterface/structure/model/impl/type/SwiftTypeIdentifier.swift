class SwiftTypeIdentifier: SwiftType, TypeIdentifier {

    let parentType: TypeIdentifier?
    let typeName: String
    let genericArguments: [Type]

    init(text: String, children: [Element], offset: Int64, length: Int64, typeName: String, genericArguments: [Type], parentType: TypeIdentifier?) {
        self.parentType = parentType
        self.typeName = typeName
        self.genericArguments = genericArguments
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypeIdentifier(self)
    }
}
