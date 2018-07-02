public protocol Parameter: Element {
    var typeAnnotation: TypeAnnotation { get }
    var defaultArgumentClause: DefaultArgumentClause? { get }
}
