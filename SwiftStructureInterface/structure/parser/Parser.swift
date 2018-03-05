import Lexer
import Source

class Parser<ResultType> {

    private let sourceFile: SourceFile
    private let lexer: Lexer

    init(lexer: Lexer, sourceFile: SourceFile) {
        self.lexer = lexer
        self.sourceFile = sourceFile
    }

    func parse() -> ResultType {
        fatalError("override me")
    }

    func convert(_ location: SourceLocation) -> Int64? {
        let zeroBasedColumn = location.column - 1
        return LocationConverter.convert(line: location.line, column: zeroBasedColumn, in: sourceFile.content)!
    }

    func getCurrentStartLocation() -> SourceLocation {
        return getCurrentRange().start
    }

    func getCurrentEndLocation() -> SourceLocation {
        return getCurrentRange().end
    }

    func getCurrentRange() -> SourceRange {
        return lexer.look().sourceRange
    }

    func getLength(_ string: String) -> Int64 {
        return Int64(string.utf8.count)
    }

    func peekAtNextIdentifier() -> String? {
        return lexer.look().kind.namedIdentifier
    }

    func isNext(_ kind: Token.Kind) -> Bool {
        return lexer.look().kind == kind
    }

    func advance() {
        lexer.advance()
    }

    func advance(if kind: Token.Kind) {
        if isNext(kind) {
            advance()
        }
    }

    func getString(offset: Int64, length: Int64) -> String? {
        return getSubstring(from: getFileContents(), offset: offset, length: length)
    }

    func getFileContents() -> String {
        return sourceFile.content
    }

    func parseInheritanceClause() -> [NamedElement] {
        return InheritanceClauseParser(lexer: lexer, sourceFile: sourceFile).parse()
    }

    func parseInheritanceType() -> NamedElement {
        return TypeIdentifierParser(lexer: lexer, sourceFile: sourceFile).parse()
    }

    func parseTypeCodeBlock() -> CodeBlock {
        return CodeBlockParser(lexer: lexer, sourceFile: sourceFile).parse()
    }

    func parseDeclarations() -> [Element] {
        return DeclarationsParser(lexer: lexer, sourceFile: sourceFile).parse()
    }

    func parseProtocol() -> Element {
        return ProtocolParser(lexer: lexer, sourceFile: sourceFile).parse()
    }
}
