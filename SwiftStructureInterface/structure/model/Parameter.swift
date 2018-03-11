protocol Parameter: Element {
    var type: Element { get }
    var externalParameterName: String? { get }
    var localParameterName: String { get }
}
