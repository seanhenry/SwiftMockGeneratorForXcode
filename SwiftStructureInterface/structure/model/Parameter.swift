public protocol Parameter: Element {
    var typeAnnotation: TypeAnnotation { get }
    var externalParameterName: String? { get }
    var localParameterName: String { get }
}
