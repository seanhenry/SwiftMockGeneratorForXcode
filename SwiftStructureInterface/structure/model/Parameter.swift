public protocol Parameter: Element {
    var type: Type { get }
    var externalParameterName: String? { get }
    var localParameterName: String { get }
}
