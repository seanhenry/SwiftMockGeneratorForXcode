public protocol VariableDeclaration: NamedElement {
    var type: Type { get }
    var isWritable: Bool { get }
}
