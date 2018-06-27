class FileImpl: ElementImpl, File {

    var retainCount = 0

    override init(children: [Element]) {
        super.init(children: children)
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
