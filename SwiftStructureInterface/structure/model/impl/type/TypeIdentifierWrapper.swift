class TypeIdentifierWrapper<T: TypeIdentifier>: ElementWrapper<T>, TypeIdentifier {

    var parentType: TypeIdentifier? {
        return managed.parentType
    }

    var typeName: String {
        return managed.typeName
    }

    var genericArguments: [Type] {
        return managed.genericArguments
    }
}
