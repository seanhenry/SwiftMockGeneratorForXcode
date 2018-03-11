import Lexer

class Parser<ResultType> {

    private let fileContents: String
    private let lexer: SwiftLexer
    class LookAheadError: Swift.Error {}

    required init(lexer: SwiftLexer, fileContents: String) {
        self.lexer = lexer
        self.fileContents = fileContents
    }

    func parse() -> ResultType {
        fatalError("override me")
    }

    // MARK: - Strings

    func getLength(_ string: String) -> Int64 {
        return Int64(string.utf8.count)
    }

    func getString(offset: Int64, length: Int64) -> String? {
        return getSubstring(from: getFileContents(), offset: offset, length: length)
    }

    func getFileContents() -> String {
        return fileContents
    }

    // MARK: - Locations

    func convert(_ location: LineColumn) -> Int64? {
        return LocationConverter.convert(line: location.line, column: location.column, in: getFileContents())!
    }

    // MARK: - Lexer

    func getCurrentStartLocation() -> LineColumn {
        return lexer.getCurrentStartLocation()
    }

    func getCurrentEndLocation() -> LineColumn {
        return lexer.getCurrentEndLocation()
    }

    func getPreviousEndLocation() -> LineColumn {
        return lexer.getPreviousEndLocation()
    }

    func peekAtNextIdentifier() -> String? {
        return peekAtNextKind().namedIdentifier
    }

    func isNext(_ kind: Token.Kind) -> Bool {
        return lexer.isNext(kind)
    }

    func isNext(_ kinds: [Token.Kind]) -> Bool {
        return lexer.isNext(kinds)
    }

    func isNext(_ scalar: UnicodeScalar) -> Bool {
        return lexer.isNext(scalar)
    }

    func peekAtNextKind() -> Token.Kind {
        return lexer.peekAtNextKind()
    }

    func advance() {
        lexer.advance()
    }

    func advanceOperator(_ scalar: UnicodeScalar) {
        lexer.advanceOperator(scalar)
    }

    func setCheckPoint() -> String {
        return lexer.setCheckPoint()
    }

    func restoreCheckPoint(_ id: String) {
        lexer.restoreCheckPoint(id)
    }

    // MARK: - Helpers

    func advance(if kind: Token.Kind) {
        if isNext(kind) {
            advance()
        }
    }

    func advance(if scalar: UnicodeScalar) {
        if isNext(scalar) {
            advanceOperator(scalar)
        }
    }

    func advanceOrFail(if kind: Token.Kind) throws {
        if isNext(kind) {
            advance()
        } else {
            throw LookAheadError()
        }
    }

    func advanceOrFail(if scalar: UnicodeScalar) throws {
        if isNext(scalar) {
            advanceOperator(scalar)
        } else {
            throw LookAheadError()
        }
    }

    func isPrefixOperator(_ string: String) -> Bool {
        if case let .prefixOperator(op) = peekAtNextKind() {
            return op == string
        }
        return false
    }

    func isPostfixOperator(_ string: String) -> Bool {
        if case let .postfixOperator(op) = peekAtNextKind() {
            return op == string
        }
        return false
    }

    func isBinaryOperator(_ string: String) -> Bool {
        if case let .binaryOperator(op) = peekAtNextKind() {
            return op == string
        }
        return false
    }

    func isNextDeclaration(_ declaration: Token.Kind) -> Bool {
        let c = setCheckPoint()
        _ = parseAttributes()
        skipDeclarationModifiers()
        let isNext = self.isNext(declaration)
        restoreCheckPoint(c)
        return isNext
    }

    func peekAtNextImplicitParameterName() -> String? {
        if case let .implicitParameterName(name) = peekAtNextKind() {
            return "$" + String(name)
        }
        return nil
    }

    func skipDeclarationModifiers() {
        _ = parseDeclarationModifiers()
    }

    func append(_ kind: Token.Kind, value: String, to string: inout String) throws {
        if isNext(kind) {
            advance()
            string.append(value)
        } else {
            throw LookAheadError()
        }
    }

    func tryToAppend(_ kind: Token.Kind, value: String, to string: inout String) {
        if isNext(kind) {
            advance()
            string.append(value)
        }
    }

    func appendBinaryOperator(_ op: String, value: String, to string: inout String) throws {
        if isBinaryOperator(op) {
            advance()
            string.append(value)
        } else {
            throw LookAheadError()
        }
    }

    func tryToAppendBinaryOperator(_ op: String, value: String, to string: inout String) {
        if isBinaryOperator(op) {
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
            throw LookAheadError()
        }
    }

    func tryToAppendIdentifier(to string: inout String) {
        if let argument = peekAtNextIdentifier() {
            advance()
            string += argument
        }
    }

    func tryToAppendTypeAnnotation(to string: inout String) {
        tryToAppend(.colon, value: ": ", to: &string)
        tryToAppendAttributes(to: &string)
        tryToAppendInout(to: &string)
        tryToAppendType(to: &string)
    }

    func tryToAppendAttributes(to string: inout String) {
        let attributes = parseAttributes()
        if attributes != "" {
            string.append(attributes + " ")
        }
    }

    func tryToAppendType(to string: inout String) {
        string.append(parseType().text)
    }

    func tryToAppendInout(to string: inout String) {
        tryToAppend(.inout, value: "inout ", to: &string)
    }

    // MARK: - Parsers

    func parseTypeInheritanceClause() -> [Element] {
        return parse(TypeInheritanceClauseParser.self)
    }

    func parseType() -> Type {
        return parse(TypeParser.self)
    }

    func parseTypeCodeBlock() -> CodeBlock {
        return parse(CodeBlockParser.self)
    }

    func parseDeclarations() -> [Element] {
        return parse(DeclarationsParser.self)
    }

    func parseProtocol() -> Element {
        return parseDeclaration(ProtocolDeclarationParser.self, .protocol)
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

    func parseFunctionDeclaration() -> NamedElement {
        return parseDeclaration(FunctionDeclarationParser.self, .func)
    }

    func parseFunctionDeclarationParameterClause() -> [MethodParameter] {
        return parse(FunctionDeclarationParser.ParameterClauseParser.self)
    }

    func parseFunctionDeclarationParameter() -> MethodParameter {
        return parse(FunctionDeclarationParser.ParameterParser.self)
    }

    func parseFunctionDeclarationResult() -> Element {
        return parse(FunctionDeclarationParser.ResultParser.self)
    }

    func parseDeclarationModifiers() -> String {
        return parse(DeclarationModifierParser.self)
    }

    func parseGenericParameterClause() -> String {
        return parse(GenericParameterClauseParser.self)
    }

    func parseTypealiasAssignment() -> Element {
        return parse(TypealiasAssignmentParser.self)
    }

    func parseAssociatedTypeDeclaration() -> Element {
        return parseDeclaration(AssociatedTypeDeclarationParser.self, .identifier("associatedtype"))
    }

    private func parse<T, P: Parser<T>>(_ parserType: P.Type) -> T {
        return P(lexer: lexer, fileContents: fileContents).parse()
    }

    private func parseDeclaration<T, P: DeclarationParser<T>>(_ parserType: P.Type, _ token: Token.Kind) -> T {
        return P(lexer: lexer, fileContents: fileContents, declarationToken: token).parse()
    }
}
