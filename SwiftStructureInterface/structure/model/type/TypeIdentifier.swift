public protocol TypeIdentifier: Type {
    var parentType: TypeIdentifier? { get }
    var genericArgumentClause: GenericArgumentClause { get }
}
