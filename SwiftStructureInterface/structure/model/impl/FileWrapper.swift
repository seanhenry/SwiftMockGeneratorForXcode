class FileWrapper: ElementWrapper, File {

    let managedFile: File

    init(_ element: File) {
        self.managedFile = element
        super.init(element)
    }

    override func accept(_ visitor: ElementVisitor) {
        visitor.visitFile(self)
    }
}
