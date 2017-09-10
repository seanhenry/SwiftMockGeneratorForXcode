protocol Element: PositionedElement {
    var text: String { get }
    var children: [Element] { get }
    weak var file: File? { get set }
    func accept(_ visitor: ElementVisitor)
}
