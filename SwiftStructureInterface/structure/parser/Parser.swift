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
        return peekAtNextKind().namedIdentifier
    }

    func isNext(_ kind: Token.Kind) -> Bool {
        return peekAtNextKind() == kind
    }

    func isNext(_ kind: [Token.Kind]) -> Bool {
        return kind.contains(peekAtNextKind())
    }

    func peekAtNextKind() -> Token.Kind {
        return lexer.look().kind
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
        return parse(InheritanceClauseParser.self)
    }

    func parseInheritanceType() -> NamedElement {
        return parse(TypeIdentifierParser.self)
    }

    func parseTypeCodeBlock() -> CodeBlock {
        return parse(CodeBlockParser.self)
    }

    func parseDeclarations() -> [Element] {
        return parse(DeclarationsParser.self)
    }

    func parseProtocol() -> Element {
        return parse(ProtocolParser.self)
    }

    func parseAttributes() -> String {
        return parse(AttributeParser.self)
    }

    func parseRequirementList() -> String {
        return parse(RequirementListParser.self)
    }

    func parseWhereClause() -> String {
        return parse(GenericWhereClauseParser.self)
    }

    private func parse<T, P: Parser<T>>(_ parserType: P.Type) -> T {
        return P(lexer: lexer, sourceFile: sourceFile).parse()
    }
}
