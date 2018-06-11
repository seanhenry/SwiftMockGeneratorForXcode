class OptionalTypeWrapper<T: OptionalType>: TypeWrapper<T>, OptionalType {

    var type: Type {
        return managed.type
    }
}
