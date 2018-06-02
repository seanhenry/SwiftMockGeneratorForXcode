public protocol TypeDeclaration: NamedElement, CodeBlockContainer {
    var accessLevelModifier: AccessLevelModifier { get }
    var inheritedTypes: [Element] { get }
}
