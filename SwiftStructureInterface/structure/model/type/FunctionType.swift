public protocol FunctionType: Type {
    var attributes: [String] { get }
    var arguments: TupleType { get }
    var returnType: Element { get }
    var `throws`: Bool { get }
    var `rethrows`: Bool { get }
}
