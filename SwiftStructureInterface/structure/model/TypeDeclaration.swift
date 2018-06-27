public protocol TypeDeclaration: Declarations, NamedElement {
    var accessLevelModifier: AccessLevelModifier { get }
    var typeInheritanceClause: TypeInheritanceClause { get }
    var codeBlock: CodeBlock { get }
}
