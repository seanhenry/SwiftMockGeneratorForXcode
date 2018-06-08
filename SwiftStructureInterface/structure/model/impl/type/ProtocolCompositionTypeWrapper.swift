class ProtocolCompositionTypeWrapper<T: ProtocolCompositionType>: TypeWrapper<T>, ProtocolCompositionType {
    
    var types: [Type] {
        return managed.types
    }
}
