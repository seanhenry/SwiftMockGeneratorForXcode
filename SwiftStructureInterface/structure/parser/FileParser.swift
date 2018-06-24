import Lexer
import Source

class FileParser: Parser<File> {

    convenience init(fileContents: String) {
        let sourceFile = SourceFile(content: fileContents)
        let lexer = SwiftASTLexer(lexer: Lexer(source: sourceFile))
        let locationConverter = CachedLocationConverter(fileContents)
        self.init(lexer: lexer, fileContents: fileContents, locationConverter: locationConverter)
    }

    convenience init?(filePath: String) {
        guard let contents = try? String(contentsOfFile: filePath) else { return nil }
        self.init(fileContents: contents)
    }

    required init(lexer: SwiftLexer, fileContents: String, locationConverter: CachedLocationConverter) {
        super.init(lexer: lexer, fileContents: fileContents, locationConverter: locationConverter)
    }

    override func parse(start: LineColumn) -> File {
        return parseFile()
    }

    private func parseFile() -> File {
        return FileImpl(children: parseDeclarations())
    }
}
