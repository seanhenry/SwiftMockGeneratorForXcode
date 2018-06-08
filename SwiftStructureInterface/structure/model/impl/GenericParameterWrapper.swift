class GenericParameterWrapper<T: GenericParameter>: ElementWrapper<T>, GenericParameter {

    var typeName: String {
        return managed.typeName
    }

    var typeIdentifier: TypeIdentifier? {
        return managed.typeIdentifier
    }

    var protocolComposition: ProtocolCompositionType? {
        return managed.protocolComposition
    }
}
