class WriteFileResolver: ResolverDecorator {

    private let tempFileWriter: TempFileWriterUtil

    init(_ decorator: Resolver?, fileWriter: TempFileWriterUtil) {
        self.tempFileWriter = fileWriter
        super.init(decorator)
    }

    override func resolve(_ element: Element) -> Element? {
        guard let file = element.file else {
            return nil
        }
        tempFileWriter.write(file.text)
        return super.resolve(element)
    }
}
