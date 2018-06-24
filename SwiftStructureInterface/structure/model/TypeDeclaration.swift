public protocol TypeDeclaration: Declarations {
    var accessLevelModifier: AccessLevelModifier { get }
    var inheritedTypes: [Element] { get }
    var declarations: [Element] { get }
}
