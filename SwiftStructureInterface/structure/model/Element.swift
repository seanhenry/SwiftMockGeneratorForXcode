public protocol Element: class {
    var text: String { get }
    var children: [Element] { get }
    var file: File? { get }
    var parent: Element? { get }
    func accept(_ visitor: ElementVisitor)
    func isIdentical(to: Element) -> Bool
}
