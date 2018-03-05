import Lexer
import Source

class Parser<ResultType> {

    private let sourceFile: SourceFile
    private let lexer: Lexer
    private let accessLevelModifiers = Token.Kind.accessLevelModifiers

    required init(lexer: Lexer, sourceFile: SourceFile) {
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

    func isNext(_ kind: [Token.Kind]) -> Bool {
        return kind.contains(lexer.look().kind)
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

    func isNextDeclaration(_ declaration: Token.Kind) -> Bool {
        let c = lexer.checkPoint()
        skipAccessModifier()
        _ = parseAttributes()
        let isNext = self.isNext(declaration)
        lexer.restore(fromCheckpoint: c)
        return isNext
    }

    func skipAccessModifier() {
        if isNext(accessLevelModifiers) {
            advance()
        }
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

    func parseAttributes() -> String {
        return AttributeParser(lexer: lexer, sourceFile: sourceFile).parse()
    }
}
