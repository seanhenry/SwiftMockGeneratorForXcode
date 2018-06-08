import SourceKittenFramework

class ElementImpl: Element, PositionedElement {

    static let errorElement = ElementImpl(text: "", children: [], offset: -1, length: -1)
    let text: String
    let children: [Element]
    let offset: Int64
    let length: Int64
    private var weakChildrenFile: File?
    var file: File?
    weak var parent: Element?

    init(text: String, children: [Element], offset: Int64, length: Int64) {
        self.text = text
        self.children = children
        self.offset = offset
        self.length = length
        children.map { $0 as? ElementImpl
                }
                .forEach { $0?.parent = self }
    }

    func accept(_ visitor: ElementVisitor) {
        precondition(type(of: self) == ElementImpl.self)
        visitor.visitElement(self)
    }
}
