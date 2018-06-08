class SwiftFile: ElementImpl, File {

    var retainCount = 0

    override init(text: String, children: [Element], offset: Int64, length: Int64) {
        super.init(text: text, children: children, offset: offset, length: length)
        let visitor = FileSettingVisitor(file: self)
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
            (element as? ElementImpl)?.file = file
            super.visitElement(element)
        }
    }
}
