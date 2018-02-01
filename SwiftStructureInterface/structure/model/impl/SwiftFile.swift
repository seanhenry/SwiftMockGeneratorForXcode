class SwiftFile: SwiftElement, File {

    override init(text: String, children: [Element], offset: Int64, length: Int64) {
        super.init(text: text, children: children, offset: offset, length: length)
        let visitor = FileSettingVisitor(file: WeakChildrenSwiftFile(text: text, children: children, offset: offset, length: length))
        accept(RecursiveElementVisitor(visitor: visitor))
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visit(self)
        super.accept(visitor)
    }

    private class FileSettingVisitor: ElementVisitor {

        let file: File

        init(file: File) {
            self.file = file
        }

        func visit(_ element: SwiftElement) {
            element.file = file
        }

        func visit(_ element: SwiftTypeElement) {
            element.inheritedTypes.forEach { type in
                type.file = file
            }
        }

        func visit(_ element: SwiftFile) {
        }

        func visit(_ element: SwiftMethodElement) {
            element.parameters.forEach { parameter in
                parameter.file = file
                parameter.type.file = file
            }
        }

        func visit(_ element: SwiftPropertyElement) {
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
