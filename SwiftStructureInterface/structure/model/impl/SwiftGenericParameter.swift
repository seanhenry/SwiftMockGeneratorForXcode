class SwiftGenericParameter: ElementImpl, GenericParameter {

    let typeName: String
    let typeIdentifier: TypeIdentifier?
    let protocolComposition: ProtocolCompositionType?

    static let errorGenericParameter = SwiftGenericParameter(text: "", children: [], offset: -1, length: -1, typeName: "", typeIdentifier: nil, protocolComposition: nil)

    init(text: String, children: [Element], offset: Int64, length: Int64, typeName: String, typeIdentifier: TypeIdentifier?, protocolComposition: ProtocolCompositionType?) {
        self.typeName = typeName
        self.typeIdentifier = typeIdentifier
        self.protocolComposition = protocolComposition
        super.init(text: text, children: children, offset: offset, length: length)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitGenericParameter(self)
    }
}
