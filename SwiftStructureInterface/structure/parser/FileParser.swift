import Lexer
import Source

class FileParser: Parser<File> {

    convenience init(fileContents: String) {
        let sourceFile = SourceFile(content: fileContents)
        let lexer = SwiftASTLexer(lexer: Lexer(source: sourceFile))
        self.init(lexer: lexer, fileContents: fileContents)
    }

    required init(lexer: SwiftLexer, fileContents: String) {
        super.init(lexer: lexer, fileContents: fileContents)
    }

    override func parse() -> File {
        return parseFile()
    }

    private func parseFile() -> File {
        return SwiftFile(text: getFileContents(),
            children: parseDeclarations(),
            offset: 0,
            length: Int64(getFileContents().utf8.count))
    }
}
