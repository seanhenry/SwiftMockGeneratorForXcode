class ElementImpl: Element {

    var text: String {
        return BuildElementText.build(from: self)
    }

    var children: [Element]
    let offset: Int64
    let length: Int64
    private var weakChildrenFile: File?
    var file: File?
    weak var parent: Element?

    init(children: [Any?]) {
                .forEach { $0?.parent = self }
    }

    func accept(_ visitor: ElementVisitor) {
        precondition(type(of: self) == ElementImpl.self)
        visitor.visitElement(self)
    }

    static func appendChild(_ child: Any?, to children: inout [Element]) {
        if let child = child as? Element {
            children.append(child)
        } else if let childArray = child as? [Element] {
            children.append(contentsOf: childArray)
        }
    }
}
