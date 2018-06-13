class TypeIdentifierWrapper: TypeWrapper, TypeIdentifier {

    let managedTypeIdentifier: TypeIdentifier

    init(_ element: TypeIdentifier) {
        managedTypeIdentifier = element
        super.init(element)
    }

    var parentType: TypeIdentifier? {
        return managedTypeIdentifier.parentType.flatMap(wrap)
    }

    var typeName: String {
        return managedTypeIdentifier.typeName
    }

    var genericArguments: [Type] {
        return managedTypeIdentifier.genericArguments.map(wrap)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitTypeIdentifier(self)
    }
}
