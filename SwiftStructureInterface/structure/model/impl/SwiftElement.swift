import SourceKittenFramework

class SwiftElement: Element, PositionedElement {

    let name: String
    let text: String
    let children: [Element]
    let offset: Int64
    let length: Int64
    weak var file: File?

    init(name: String, text: String, children: [Element], offset: Int64, length: Int64) {
        self.name = name
        self.text = text
        self.children = children
        self.offset = offset
        self.length = length
    }

    func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
    }
}
