import Lexer
import Source

class FileParser: Parser<File> {

    convenience init(fileContents: String) {
        let sourceFile = SourceFile(content: fileContents)
        let lexer = SwiftASTLexer(lexer: Lexer(source: sourceFile))
        self.init(lexer: lexer, fileContents: fileContents)
    }

    convenience init?(filePath: String) {
        guard let contents = try? String(contentsOfFile: filePath) else { return nil }
        self.init(fileContents: contents)
    }

    required init(lexer: SwiftLexer, fileContents: String) {
        super.init(lexer: lexer, fileContents: fileContents)
    }

    override func parse(offset: Int64) -> File {
        return parseFile()
    }

    private func parseFile() -> File {
        return SwiftFile(text: getFileContents(),
            children: parseDeclarations(),
            offset: 0,
            length: Int64(getFileContents().utf8.count))
    }
}
