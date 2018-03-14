public protocol FunctionDeclaration: NamedElement {
    var genericParameterClause: GenericParameterClause? { get }
    var parameters: [Parameter] { get }
    var returnType: Element? { get }
    var `throws`: Bool { get }
}
