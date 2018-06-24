public protocol Element: class, PositionedElement {
    var text: String { get }
    var children: [Element] { set get }
    var file: File? { get }
    var parent: Element? { get }
    func accept(_ visitor: ElementVisitor)
}
