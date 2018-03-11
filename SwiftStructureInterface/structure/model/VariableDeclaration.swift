protocol VariableDeclaration: NamedElement {
    var type: Type { get }
    var isWritable: Bool { get }
    var attribute: String? { get }
}
