class FileImpl: ElementImpl, File {

    var retainCount = 0
    let topLevelDeclarations: [Element]

    init(text: String, offset: Int64, length: Int64, topLevelDeclarations: [Element]) {
        self.topLevelDeclarations = topLevelDeclarations
        super.init(text: text, children: topLevelDeclarations, offset: offset, length: length)
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
