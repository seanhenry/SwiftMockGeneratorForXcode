class SwiftFile: SwiftElement, File {

    override init(name: String, text: String, children: [Element], offset: Int64, length: Int64) {
        super.init(name: name, text: text, children: children, offset: offset, length: length)
        let visitor = FileSettingVisitor(file: self)
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
                var type = type
                type.file = file
            }
        }

        func visit(_ element: SwiftFile) {
        }

        func visit(_ element: SwiftMethodElement) {
        }

        func visit(_ element: SwiftPropertyElement) {
        }
    }
}
