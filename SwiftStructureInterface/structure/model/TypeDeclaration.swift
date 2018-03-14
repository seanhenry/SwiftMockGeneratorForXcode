public protocol TypeDeclaration: NamedElement, CodeBlockContainer {
    var inheritedTypes: [Element] { get }
}
