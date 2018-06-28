public protocol FunctionDeclaration: NamedElement, Declarations {
    var genericParameterClause: GenericParameterClause? { get }
    var parameterClause: ParameterClause { get }
    var returnType: FunctionResult? { get }
    var declarations: [Element] { get }
}
