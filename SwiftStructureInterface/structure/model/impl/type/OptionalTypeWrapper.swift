class OptionalTypeWrapper: TypeWrapper, OptionalType {

    let managedOptionalType: OptionalType

    init(_ element: OptionalType) {
        managedOptionalType = element
        super.init(element)
    }

    var type: Type {
        return wrap(managedOptionalType.type)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitOptionalType(self)
    }
}
