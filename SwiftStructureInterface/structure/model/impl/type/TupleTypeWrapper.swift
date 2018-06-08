class TupleTypeWrapper<T: TupleType>: TypeWrapper<T>, TupleType {

    var elements: [TupleTypeElement] {
        return managed.elements
    }
}
