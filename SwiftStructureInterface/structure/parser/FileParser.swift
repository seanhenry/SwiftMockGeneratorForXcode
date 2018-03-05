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
        return TypeIdentifierParser(lexer: lexer, sourceFile: sourceFile).parse()
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
}
