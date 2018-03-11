protocol VariableDeclaration: NamedElement {
    var type: String { get }
    var isWritable: Bool { get }
    var attribute: String? { get }
}
