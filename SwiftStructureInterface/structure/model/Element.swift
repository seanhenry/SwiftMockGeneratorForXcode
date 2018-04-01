public protocol Element: class, PositionedElement {
    var text: String { get }
    var children: [Element] { get }
    var file: File? { get set }
    var parent: Element? { get set }
    func accept(_ visitor: ElementVisitor)
}
