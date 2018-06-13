class GenericParameterWrapper: ElementWrapper, GenericParameter {

    let managedGenericParameter: GenericParameter

    init(_ element: GenericParameter) {
        managedGenericParameter = element
        super.init(element)
    }

    var typeName: String {
        return managedGenericParameter.typeName
    }

    var typeIdentifier: TypeIdentifier? {
        return managedGenericParameter.typeIdentifier.flatMap(wrap)
    }

    var protocolComposition: ProtocolCompositionType? {
        return managedGenericParameter.protocolComposition.flatMap(wrap)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitGenericParameter(self)
    }
}
