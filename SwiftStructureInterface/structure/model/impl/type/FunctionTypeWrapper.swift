class FunctionTypeWrapper: TypeWrapper, FunctionType {

    let managedFunctionType: FunctionType

    init(_ element: FunctionType) {
        managedFunctionType = element
        super.init(element)
    }

    var attributes: [String] {
        return managedFunctionType.attributes
    }

    var arguments: TupleType {
        return wrap(managedFunctionType.arguments)
    }

    var returnType: Element {
        return wrap(managedFunctionType.returnType)
    }

    var `throws`: Bool {
        return managedFunctionType.`throws`
    }

    var `rethrows`: Bool {
        return managedFunctionType.`rethrows`
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitFunctionType(self)
    }
}
