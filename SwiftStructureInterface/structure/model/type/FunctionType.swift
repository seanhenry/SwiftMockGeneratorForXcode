public protocol FunctionType: Type {
    var attributes: Attributes { get }
    var arguments: TupleType { get }
    var returnType: Type { get }
}
