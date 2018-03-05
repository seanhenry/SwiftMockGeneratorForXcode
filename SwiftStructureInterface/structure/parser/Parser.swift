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
        if isNext(.protocol) {
            advance()
            parseProtocol(start: start).map { elements.append($0) }
        }
        return elements
    }

    private func parseProtocol(start: SourceLocation) -> Element? {
        let offset = convert(start)!
        guard let name = peekAtNextIdentifier() else { return nil }
        advance()
        if let inheritanceClause = parseInheritanceClause(),
           let (bodyOffset, bodyLength, bodyEnd, declarations) = parseTypeCodeBlock() {
            let length = bodyEnd - offset
            let text = getSubstring(from: sourceFile.content, offset: offset, length: length)!
            return SwiftTypeElement(
                name: name,
                text: text,
                children: declarations,
                inheritedTypes: inheritanceClause,
                offset: offset,
                length: length,
                bodyOffset: bodyOffset,
                bodyLength: bodyLength)
        }
        return nil
    }

    private func parseInheritanceClause() -> [NamedElement]? {
        guard isNext(.colon) else { return [] }
        var types = [NamedElement]()
        repeat {
            advance()
            parseInheritanceType().map { types.append($0) }
        } while isNext(.comma)
        return types
    }

    private func parseInheritanceType() -> NamedElement? {
        let start = getCurrentStartLocation()
        if let identifier = peekAtNextIdentifier() {
            advance()
            let offset = convert(start)!
            return SwiftInheritedType(name: identifier,
                text: identifier,
                children: [],
                offset: offset,
                length: getLength(identifier))
        }
        return nil
    }

    private func parseTypeCodeBlock() -> (offset: Int64, length: Int64, bodyEnd: Int64, declarations: [Element])? {
        let bodyStart = getCurrentEndLocation()
        advance(if: .leftBrace)
        let bodyOffset = convert(bodyStart)!

        // TODO: only parse declarations if body is complete (need to add method/var parser first)
        let declarations = parseDeclarations()

        let bodyLength = convert(getCurrentStartLocation())! - bodyOffset
        var rightBraceLength: Int64 = 0
        if isNext(.rightBrace) {
            rightBraceLength = 1
            advance()
        }
        return (bodyOffset, bodyLength, bodyOffset + bodyLength + rightBraceLength, declarations)
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

    private func getLength(_ string: String) -> Int64 {
        return Int64(string.utf8.count)
    }

    private func peekAtNextIdentifier() -> String? {
        return lexer.look().kind.namedIdentifier
    }

    private func isNext(_ kind: Token.Kind) -> Bool {
        return lexer.look().kind == kind
    }

    private func advance() {
        lexer.advance()
    }

    private func advance(if kind: Token.Kind) {
        if isNext(kind) {
            advance()
        }
    }
}
