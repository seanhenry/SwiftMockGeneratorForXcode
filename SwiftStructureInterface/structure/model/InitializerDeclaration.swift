public protocol InitializerDeclaration: Element {
    var parameterClause: ParameterClause { get }
    var declarations: [Element] { get }
}
