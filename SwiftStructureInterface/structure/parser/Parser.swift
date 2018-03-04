import Lexer
import Source

class Parser {

    private let lexer: Lexer
    private let sourceFile: SourceFile
    private var currentOffset: Int64

    init(fileContents: String) {
        sourceFile = SourceFile(content: fileContents)
        lexer = Lexer(source: sourceFile)
        currentOffset = 0
    }

    func parse() -> File? {
        return parseFile()
    }

    private func parseFile() -> File? {
        return SwiftFile(text: sourceFile.content,
            children: parseDeclarations(),
            offset: 0,
            length: Int64(sourceFile.content.utf8.count))
    }

    private func parseDeclarations() -> [Element] {
        let start = getCurrentStartLocation()
        if case .protocol = lexer.read(.protocol) {
            return parseProtocol(start: start).map { [$0] } ?? []
        }
        return []
    }

    private func parseProtocol(start: SourceLocation) -> Element? {
        let offset = convert(start)!
        if let name = getNextName(),
           let (bodyOffset, bodyLength, declarations) = parseTypeCodeBlock() {
            let length = bodyOffset + bodyLength + 1
            let text = getSubstring(from: sourceFile.content, offset: offset, length: length)!
            return SwiftTypeElement(
                name: name,
                text: text,
                children: declarations,
                inheritedTypes: [],
                offset: offset,
                length: length,
                bodyOffset: bodyOffset,
                bodyLength: bodyLength)
        }
        return nil
    }

    private func parseTypeCodeBlock() -> (offset: Int64, length: Int64, declarations: [Element])? {
        let bodyStart = getCurrentEndLocation()
        if lexer.match(.leftBrace) {
            let bodyOffset = convert(bodyStart)!
            let bodyEnd = getCurrentStartLocation()
            if lexer.match(.rightBrace) {
                let bodyEnd = convert(bodyEnd)!
                return (bodyOffset, bodyEnd - bodyOffset, [])
            }
        }
        return nil
    }

    private func getNextName() -> String? {
        if let name = lexer.look().kind.structName {
            lexer.advance()
            return name
        }
        return nil
    }

    private func convert(_ location: SourceLocation) -> Int64? {
        let zeroBasedColumn = location.column - 1
        return LocationConverter.convert(line: location.line, column: zeroBasedColumn, in: sourceFile.content)!
    }

    private func getCurrentStartLocation() -> SourceLocation {
        return getCurrentRange().start
    }

    private func getCurrentEndLocation() -> SourceLocation {
        return getCurrentRange().end
    }

    private func getCurrentRange() -> SourceRange {
        return lexer.look().sourceRange
    }

}
