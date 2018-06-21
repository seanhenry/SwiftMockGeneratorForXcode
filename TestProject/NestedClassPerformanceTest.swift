import Lexer

class Parser<ResultType> {

    private let fileContents: String
    private var lexer: SwiftLexer
    private let locationConverter: CachedLocationConverter
    class LookAheadError: Swift.Error {}

    required init(lexer: SwiftLexer, fileContents: String, locationConverter: CachedLocationConverter) {
        self.lexer = lexer
        self.fileContents = fileContents
        self.locationConverter = locationConverter
    }

    func parse() -> ResultType {
        let start = getCurrentStartLocation()
        return parse(start: start)
    }

    func parse(start: LineColumn) -> ResultType {
        fatalError("override me")
    }

    func createElement<ResultType: Element>(start: LineColumn, parameters: (Int64, Int64, String) -> ResultType) -> ResultType? {
        let end = getPreviousEndLocation()
        if let offset = convert(start),
           let endOffset = convert(end),
           let text = getSubstring(start, end) {
            return parameters(offset, endOffset - offset, text)
        }
        return nil
    }

    // MARK: - Strings

    private func getSubstring(_ start: LineColumn, _ end: LineColumn) -> String? {
        if let startIndex = locationConverter.convertToIndex(line: start.line, column: start.column),
           let endIndex = locationConverter.convertToIndex(line: end.line, column: end.column),
           startIndex <= endIndex {
            return String(getFileContents().utf8[startIndex..<endIndex])
        }
        return nil
    }

    func getFileContents() -> String {
        return fileContents
    }

    // MARK: - Locations

    func convert(_ location: LineColumn) -> Int64? {
        return locationConverter.convertToOffset(line: location.line, column: location.column)
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

    func peekAtNextParameterIdentifier() -> String? {
        if let name = peekAtNextKind().namedIdentifier?.text {
            return escapeParameterIdentifier(name)
        } else if isNext(.booleanLiteral(false)) {
            return "false"
        } else if isNext(.booleanLiteral(true)) {
            return "true"
        } else {
            return nil
        }
    }

    private func escapeParameterIdentifier(_ name: String) -> String {
        let keywords = ["inout", "let", "var"]
        if keywords.contains(name) {
            return "`\(name)`"
        }
        return name
    }

    func peekAtNextIdentifier() -> String? {
        return peekAtNextKind().namedIdentifier?.text
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

    func advance(if kinds: [Token.Kind]) {
        if isNext(kinds) {
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

    func advanceIfIdentifierOrFail() throws {
        if peekAtNextIdentifier() != nil {
            advance()
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

    func tryToAppendAttributes(to string: inout String) {
        let attributes = parseAttributes()
        string.append(attributes.joined(separator: " "))
    }

    func tryToAppendType(to string: inout String) {
        string.append(parseType().text)
    }

    func tryToAppendInout(to string: inout String) {
        tryToAppend(.inout, value: "inout ", to: &string)
    }

    func skipInout() {
        advance(if: .inout)
    }

    // MARK: - Parsers

    func parseTypeInheritanceClause() -> [Element] {
        return parse(TypeInheritanceClauseParser.self)
    }

    func parseType() -> Type {
        return parse(TypeParser.self)
    }

    func parseTypeAnnotation() -> TypeAnnotation {
        return parse(TypeAnnotationParser.self)
    }

    func parseTupleTypeElement() -> TupleTypeElement {
        return parse(TypeParser.TupleTypeElementParser.self)
    }

    func parseTypeCodeBlock() -> CodeBlock {
        return parse(CodeBlockParser.self)
    }

    func parseDeclarations() -> [Element] {
        return parse(DeclarationsParser.self)
    }

    func parseProtocolDeclaration() -> Element {
        return parseDeclaration(ProtocolDeclarationParser.self, .protocol)
    }

    func parseAttributes() -> [String] {
        return parse(AttributeParser.self)
    }

    func parseRequirementList() -> String {
        return parse(RequirementListParser.self)
    }

    func parseWhereClause() -> String {
        return parse(GenericWhereClauseParser.self)
    }

    func parseFunctionDeclaration() -> FunctionDeclaration {
        return parseDeclaration(FunctionDeclarationParser.self, .func)
    }

    func parseVariableDeclaration() -> VariableDeclaration {
        return parseDeclaration(VariableDeclarationParser.self, .var)
    }

    func parseFunctionDeclarationParameterClause() -> [Parameter] {
        return parse(FunctionDeclarationParser.ParameterClauseParser.self)
    }

    func parseFunctionDeclarationParameter() -> Parameter {
        return parse(FunctionDeclarationParser.ParameterParser.self)
    }

    func parseFunctionDeclarationResult() -> Element {
        return parse(FunctionDeclarationParser.ResultParser.self)
    }

    func parseDeclarationModifiers() -> String {
        return parse(DeclarationModifierParser.self)
    }

    func parseMutationModifiers() -> String {
        return parse(MutationModifierParser.self)
    }

    func parseGetterSetterKeywordBlock() -> GetterSetterKeywordBlock {
        return parse(GetterSetterKeywordBlockParser.self)
    }

    func parseGenericParameterClause() -> GenericParameterClause {
        return parse(GenericParameterClauseParser.self)
    }

    func parseTypealiasAssignment() -> TypealiasAssignment {
        return parse(TypealiasAssignmentParser.self)
    }

    func parseAssociatedTypeDeclaration() -> Element {
        return parseDeclaration(AssociatedTypeDeclarationParser.self, .identifier("associatedtype", false))
    }

    func parseTypealiasDeclaration() -> Element {
        return parseDeclaration(TypealiasDeclarationParser.self, .typealias)
    }

    func parseInitializerDeclaration() -> Element {
        return parseDeclaration(InitializerDeclarationParser.self, .init)
    }

    func parseSubscriptDeclaration() -> Element {
        return parseDeclaration(SubscriptDeclarationParser.self, .subscript)
    }

    func parseAccessLevelModifier() -> AccessLevelModifier {
        return parse(AccessLevelModifierParser.self)
    }

    private func parse<T, P: Parser<T>>(_ parserType: P.Type) -> T {
        return P(lexer: lexer, fileContents: fileContents, locationConverter: locationConverter).parse()
    }

    private func parseDeclaration<T, P: DeclarationParser<T>>(_ parserType: P.Type, _ token: Token.Kind) -> T {
        return P(lexer: lexer, fileContents: fileContents, declarationToken: token, locationConverter: locationConverter).parse()
    }

    class MockClass: ClosureProtocol {
        <caret>
    }
}
