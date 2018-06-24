public protocol FunctionDeclaration: NamedElement, Declarations {
    var genericParameterClause: GenericParameterClause? { get }
    var parameters: [Parameter] { get }
    var returnType: Element? { get }
    var declarations: [Element] { get }
}
