protocol Element: PositionedElement {
    var name: String { get } // name
    var text: String { get }
//    var kind: String { get } // kind
//    var file: File? { get }
//    var scope: String? { get } // accessibility
//    var parent: Element? { get }
    var children: [Element] { get }
    weak var file: File? { get set }

    func accept(_ visitor: ElementVisitor)
}
