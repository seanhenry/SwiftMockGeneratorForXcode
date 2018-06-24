public protocol TupleTypeElement: Element {
    var typeAnnotation: TypeAnnotation? { get }
    var type: Type? { get }
}
