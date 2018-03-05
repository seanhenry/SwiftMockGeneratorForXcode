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
        var elements = [Element]()
        if case .protocol = lexer.read(.protocol) {
            parseProtocol(start: start).map { elements.append($0) }
        }
        return elements
    }

    private func parseProtocol(start: SourceLocation) -> Element? {
        let offset = convert(start)!
        if let name = getNextName(),
           let (bodyOffset, bodyLength, bodyEnd, declarations) = parseTypeCodeBlock() {
            let length = bodyEnd - offset
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

    private func parseTypeCodeBlock() -> (offset: Int64, length: Int64, bodyEnd: Int64, declarations: [Element])? {
        let bodyStart = getCurrentEndLocation()
        _ = lexer.match(.leftBrace)
        let bodyOffset = convert(bodyStart)!

        // TODO: only parse declarations if body is complete (need to add method/var parser first)
        let declarations = parseDeclarations()

        let bodyLength = convert(getCurrentStartLocation())! - bodyOffset
        let rightBraceLength: Int64 = lexer.read(.rightBrace) == .rightBrace ? 1 : 0
        return (bodyOffset, bodyLength, bodyOffset + bodyLength + rightBraceLength, declarations)
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
