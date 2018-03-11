class SwiftFile: SwiftElement, File {

    override init(text: String, children: [Element], offset: Int64, length: Int64) {
        super.init(text: text, children: children, offset: offset, length: length)
        let visitor = FileSettingVisitor(file: WeakChildrenSwiftFile(text: text, children: children, offset: offset, length: length))
        accept(visitor)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitFile(self)
    }

    private class FileSettingVisitor: RecursiveElementVisitor {

        let file: File

        init(file: File) {
            self.file = file
        }

        override func visitElement(_ element: Element) {
            element.file = file
            super.visitElement(element)
        }

        override func visitParameter(_ element: Parameter) {
            super.visitParameter(element)
        }
    }

    private class WeakChildrenSwiftFile: File {

        let text: String
        let offset: Int64
        let length: Int64
        var children: [Element] { return weakChildren.flatMap { $0.contents } }
        var file: File? {
            set { }
            get { return nil }
        }
        var parent: Element? {
            set { }
            get { return nil }
        }
        private let weakChildren: [WeakElement]

        private class WeakElement {
            weak var contents: Element?
            init(_ contents: Element?) { self.contents = contents }
        }

        init(text: String, children: [Element], offset: Int64, length: Int64) {
            self.text = text
            self.offset = offset
            self.length = length
            weakChildren = children.map { WeakElement($0) }
        }

        func accept(_ visitor: ElementVisitor) {}
    }
}
