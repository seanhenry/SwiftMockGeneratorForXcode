public protocol TypeAnnotation: Element {
    var attributes: Attributes { get }
    var type: Type { get }
}
