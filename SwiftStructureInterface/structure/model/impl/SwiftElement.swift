import SourceKittenFramework

class SwiftElement: Element, PositionedElement {

    let name: String
    let children: [Element]
    let offset: Int64
    let length: Int64

    init(name: String, children: [Element], offset: Int64, length: Int64) {
        self.name = name
        self.children = children
        self.offset = offset
        self.length = length
    }

    func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
    }
}
