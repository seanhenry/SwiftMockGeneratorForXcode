import Lexer
import Source

class Parser<ResultType> {

    private let sourceFile: SourceFile
    private let lexer: Lexer
    private let accessLevelModifiers = Token.Kind.accessLevelModifiers
    private var lastRange: SourceRange
    private class Error: Swift.Error {}

    required init(lexer: Lexer, sourceFile: SourceFile) {
        self.lexer = lexer
        self.sourceFile = sourceFile
        lastRange = lexer.look().sourceRange
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

    func getPreviousEndLocation() -> SourceLocation {
        return lastRange.end
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

    func isNext(_ scalar: UnicodeScalar) -> Bool {
        let cp = setCheckPoint()
        defer { restoreCheckPoint(cp) }
        return lexer.matchUnicodeScalar(scalar)
    }

    func peekAtNextKind() -> Token.Kind {
        return lexer.look().kind
    }

    func advance() {
        lastRange = getCurrentRange()
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
        let c = setCheckPoint()
        _ = parseAttributes()
        skipAccessModifier()
        let isNext = self.isNext(declaration)
        restoreCheckPoint(c)
        return isNext
    }

    func setCheckPoint() -> String {
        return lexer.checkPoint()
    }

    func restoreCheckPoint(_ id: String) {
        lexer.restore(fromCheckpoint: id)
    }

    func skipAccessModifier() {
        if isNext(accessLevelModifiers) {
            advance()
        }
    }

    func append(_ kind: Token.Kind, value: String, to string: inout String) throws {
        if isNext(kind) {
            advance()
            string.append(value)
        } else {
            throw Error()
        }
    }

    func tryToAppend(_ kind: Token.Kind, value: String, to string: inout String) {
        if isNext(kind) {
            advance()
            string.append(value)
        }
    }

    func tryToParse<T>(_ parse: () throws -> T) -> T? {
        let cp = setCheckPoint()
        do {
            return try parse()
        } catch {
            restoreCheckPoint(cp)
        }
        return nil
    }

    func appendIdentifier(to string: inout String) throws {
        if let argument = peekAtNextIdentifier() {
            advance()
            string += argument
        } else {
            throw Error()
        }
    }

    func tryToAppendIdentifier(to string: inout String) {
        if let argument = peekAtNextIdentifier() {
            advance()
            string += argument
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

    func parseProtocolComposition() -> String {
        return parse(ProtocolCompositionParser.self)
    }

    private func parse<T, P: Parser<T>>(_ parserType: P.Type) -> T {
        return P(lexer: lexer, sourceFile: sourceFile).parse()
    }
}
