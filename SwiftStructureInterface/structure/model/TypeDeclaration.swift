public protocol TypeDeclaration: NamedElement, CodeBlockContainer, Declarations {
    var accessLevelModifier: AccessLevelModifier { get }
    var inheritedTypes: [Element] { get }
}
