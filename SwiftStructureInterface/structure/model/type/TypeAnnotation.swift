public protocol TypeAnnotation: Element {
    var attributes: [String] { get }
    var isInout: Bool { get }
    var type: Type { get }
}
