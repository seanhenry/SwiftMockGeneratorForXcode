public protocol Parameter: Element {
    var typeAnnotation: TypeAnnotation { get }
    // TODO: required for class impl, blocked until Assignment is parsed
//    var defaultArgumentClause: DefaultArgumentClause { get }
}
