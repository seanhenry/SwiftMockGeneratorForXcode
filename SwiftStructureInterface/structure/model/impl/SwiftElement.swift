import SourceKittenFramework

class SwiftElement: Element, PositionedElement {

    let text: String
    let children: [Element]
    let offset: Int64
    let length: Int64
    private var weakChildrenFile: File?
    var file: File? {
        set { weakChildrenFile = newValue }
        get { return copyFile() }
    }
    weak var parent: Element?

    init(text: String, children: [Element], offset: Int64, length: Int64) {
        self.text = text
        self.children = children
        self.offset = offset
        self.length = length
        children.forEach { $0.parent = self }
    }

    func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
    }

    private func copyFile() -> File? {
        guard let file = weakChildrenFile else { return nil }
        return SwiftFile(text: file.text, children: file.children, offset: file.offset, length: file.length)
    }
}
