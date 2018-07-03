class ElementImpl: Element {

    private(set) var children: [Element]
    var file: File?
    weak var parent: Element?
    var text: String {
        return BuildElementText.build(from: self)
    }

    init(children: [Element]) {
        self.children = children
        self.children.map { $0 as? ElementImpl }
                .forEach { $0?.parent = self }
    }

    func accept(_ visitor: ElementVisitor) {
        visitor.visitElement(self)
    }

    func isIdentical(to: Element) -> Bool {
        return self === to
    }
}
