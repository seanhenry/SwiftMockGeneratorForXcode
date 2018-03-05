import Lexer
import Source

class FileParser: Parser<File> {

    private var currentOffset: Int64

    init(fileContents: String) {
        let sourceFile = SourceFile(content: fileContents)
        let lexer = Lexer(source: sourceFile)
        currentOffset = 0
        super.init(lexer: lexer, sourceFile: sourceFile)
    }

    override func parse() -> File? {
        return parseFile()
    }

    private func parseFile() -> File? {
        return SwiftFile(text: sourceFile.content,
            children: parseDeclarations(),
            offset: 0,
            length: Int64(sourceFile.content.utf8.count))
    }
}
