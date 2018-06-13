class ProtocolCompositionTypeWrapper: TypeWrapper, ProtocolCompositionType {

    let managedProtocolCompositionType: ProtocolCompositionType

    init(_ element: ProtocolCompositionType) {
        managedProtocolCompositionType = element
        super.init(element)
    }
    
    var types: [Type] {
        return managedProtocolCompositionType.types.map(wrap)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitProtocolCompositionType(self)
    }
}
