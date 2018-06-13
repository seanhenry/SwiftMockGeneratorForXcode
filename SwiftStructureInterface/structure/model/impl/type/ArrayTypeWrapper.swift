class ArrayTypeWrapper: TypeWrapper, ArrayType {

    let managedArrayType: ArrayType

    init(_ element: ArrayType) {
        managedArrayType = element
        super.init(element)
    }
    
    var elementType: Type {
        return wrap(managedArrayType.elementType)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitArrayType(self)
    }
}
