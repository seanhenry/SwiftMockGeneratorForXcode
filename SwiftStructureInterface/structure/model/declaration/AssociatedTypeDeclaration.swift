public protocol AssociatedTypeDeclaration: Declaration {
    var typeInheritanceClause: [Element] { get }
    var typealiasAssignment: TypealiasAssignment? { get }
    var genericWhereClause: GenericWhereClause? { get }
}
