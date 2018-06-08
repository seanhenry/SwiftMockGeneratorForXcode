import SourceKittenFramework

class SwiftElement: Element, PositionedElement {

    static let errorElement = SwiftElement(text: "", children: [], offset: -1, length: -1)
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
        children.map { $0 as? SwiftElement }
                .forEach { $0?.parent = self }
    }

    func accept(_ visitor: ElementVisitor) {
        precondition(type(of: self) == SwiftElement.self)
        visitor.visitElement(self)
    }
}
