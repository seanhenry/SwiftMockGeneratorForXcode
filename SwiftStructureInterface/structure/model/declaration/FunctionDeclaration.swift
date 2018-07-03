public protocol FunctionDeclaration: Declaration, NamedElement, Declarations {
    var genericParameterClause: GenericParameterClause? { get }
    var parameterClause: ParameterClause { get }
    var returnType: FunctionResult? { get }
    var declarations: [Element] { get }
    var codeBlock: CodeBlock? { get }
}
