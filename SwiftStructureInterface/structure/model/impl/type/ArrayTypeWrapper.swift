class ArrayTypeWrapper<T: ArrayType>: TypeWrapper<T>, ArrayType {
    
    var elementType: Type {
        return managed.elementType
    }
}
