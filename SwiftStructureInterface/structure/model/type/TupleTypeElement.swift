public protocol TupleTypeElement: Element {
    var label: String? { get }
    var typeAnnotation: TypeAnnotation { get }
}
