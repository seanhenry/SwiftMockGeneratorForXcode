class FunctionTypeWrapper<T: FunctionType>: TypeWrapper<T>, FunctionType {

    var attributes: [String] {
        return managed.attributes
    }

    var arguments: TupleType {
        return managed.arguments
    }

    var returnType: Element {
        return managed.returnType
    }

    var `throws`: Bool {
        return managed.`throws`
    }

    var `rethrows`: Bool {
        return managed.`rethrows`
    }
}
