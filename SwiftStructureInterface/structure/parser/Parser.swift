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

    func parse() throws -> ResultType {
        fatalError("override me")
    }

    // MARK: - Strings

    func getSubstring(_ start: LineColumn, _ end: LineColumn) -> String? {
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
        if isNext(.underscore) {
            return "_"
        }
        let next = peekAtNextKind()
        guard isIdentifier(next),
              let identifier = next.namedIdentifier else { return nil }
        switch identifier {
            case .backtickedName(let escaped): return "`\(escaped)`"
            default: return identifier.text
        }
    }

    func isIdentifier(_ kind: Token.Kind) -> Bool {
        if case .identifier(_, _) = kind {
            return true
        }
        return kind == .underscore
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

    func peekAtKind(aheadBy distance: Int) -> Token.Kind {
        return lexer.peekAtKind(aheadBy: distance)
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

    func tryToParse<T>(_ parse: () throws -> T) -> T? {
        let cp = setCheckPoint()
        do {
            return try parse()
        } catch {
            restoreCheckPoint(cp)
        }
        return nil
    }

    // MARK: - Parsers

    func parseTypeInheritanceClause() throws -> TypeInheritanceClause {
        return try parse(TypeInheritanceClauseParser.self)
    }

    func parseType() throws -> Type {
        return try parse(TypeParser.self)
    }

    func parseTypeAnnotation() throws -> TypeAnnotation {
        return try parse(TypeAnnotationParser.self)
    }

    func parseTupleTypeElement() throws -> TupleTypeElement {
        return try parse(TypeParser.TupleTypeElementParser.self)
    }

    func parseTupleTypeElementList() throws -> TupleTypeElementList {
        return try parse(TypeParser.TupleTypeElementListParser.self)
    }

    func parseCodeBlock() throws -> CodeBlock {
        return try parse(CodeBlockParser.self)
    }

    func parseProtocolDeclaration() throws -> ProtocolDeclaration {
        return try parseDeclaration(ProtocolDeclarationParser.self, .protocol)
    }

    func parseClassDeclaration() throws -> ClassDeclaration {
        return try parse(ClassDeclarationParser.self)
    }

    func parseAttributes() throws -> Attributes {
        return try parse(AttributesParser.self)
    }

    func parseRequirementList() throws -> RequirementList {
        return try parse(RequirementListParser.self)
    }

    func parseWhereClause() throws -> GenericWhereClause {
        return try parse(GenericWhereClauseParser.self)
    }

    func parseFunctionDeclaration() throws -> FunctionDeclaration {
        return try parseDeclaration(FunctionDeclarationParser.self, .func)
    }

    func parseVariableDeclaration() throws -> VariableDeclaration {
        return try parseDeclaration(VariableDeclarationParser.self, .var)
    }

    func parseParameterClause() throws -> ParameterClause {
        return try parse(ParameterClauseParser.self)
    }

    func parseParameter() throws -> Parameter {
        return try parse(ParameterParser.self)
    }

    func parseFunctionResult() throws -> FunctionResult {
        return try parse(FunctionResultParser.self)
    }

    func parseThrows() throws -> Element {
        return try parseKeyword([.throws, .rethrows])
    }

    func parseDeclarationModifier() throws -> DeclarationModifier {
        return try parse(DeclarationModifierParser.self)
    }

    func parseMutationModifier() throws -> MutationModifier {
        return try parse(MutationModifierParser.self)
    }

    func parseGetterSetterKeywordBlock() throws -> GetterSetterKeywordBlock {
        return try parse(GetterSetterKeywordBlockParser.self)
    }

    func parseGenericParameterClause() throws -> GenericParameterClause {
        return try parse(GenericParameterClauseParser.self)
    }

    func parseTypealiasAssignment() throws -> TypealiasAssignment {
        return try parse(TypealiasAssignmentParser.self)
    }

    func parseAssociatedTypeDeclaration() throws -> AssociatedTypeDeclaration {
        return try parseDeclaration(AssociatedTypeDeclarationParser.self, .identifier("associatedtype", false))
    }

    func parseTypealiasDeclaration() throws -> TypealiasDeclaration {
        return try parseDeclaration(TypealiasDeclarationParser.self, .typealias)
    }

    func parseInitializerDeclaration() throws -> InitializerDeclaration {
        return try parseDeclaration(InitializerDeclarationParser.self, .init)
    }

    func parseSubscriptDeclaration() throws -> SubscriptDeclaration {
        return try parseDeclaration(SubscriptDeclarationParser.self, .subscript)
    }

    func parseAccessLevelModifier() throws -> AccessLevelModifier {
        return try parse(AccessLevelModifierParser.self)
    }

    func parseKeyword() throws -> LeafNode {
        return try parse(KeywordParser.self)
    }

    func parseKeyword(_ kind: Token.Kind) throws -> LeafNode {
        guard isNext(kind) else {
            throw LookAheadError()
        }
        return try parse(KeywordParser.self)
    }

    func parseKeyword(_ kinds: [Token.Kind]) throws -> LeafNode {
        guard isNext(kinds) else {
            throw LookAheadError()
        }
        return try parse(KeywordParser.self)
    }

    func parseWhitespace() throws -> Whitespace {
        return try parse(WhitespaceParser.self)
    }

    func parseDeclarationIdentifier() throws -> Identifier {
        return try parse(DeclarationIdentifierParser.self)
    }

    func parseIdentifierList() throws -> IdentifierList {
        return try parse(IdentifierListParser.self)
    }

    func parseIdentifier() throws -> Identifier {
        if isIdentifierNext() {
            return try parse(IdentifierParser.self)
        }
        throw LookAheadError()
    }

    func parseIdentifier(_ string: String) throws -> Identifier {
        if isIdentifierNext([string]) {
            return try parse(IdentifierParser.self)
        }
        throw LookAheadError()
    }

    func parseIdentifier(_ strings: [String]) throws -> Identifier {
        if isIdentifierNext(strings) {
            return try parseIdentifier()
        }
        throw LookAheadError()
    }

    private func isIdentifierNext(_ strings: [String] = []) -> Bool {
        guard let identifier = peekAtNextIdentifier() else {
            return false
        }
        if strings.isEmpty {
            return true
        }
        return strings.contains { string in
            return string == identifier
        }
    }

    func parseOperator(_ op: UnicodeScalar) throws -> Element {
        if isNext(op) {
            advanceOperator(op)
            return LeafNodeImpl(text: String(op))
        }
        throw LookAheadError()
    }

    func parsePrefixOperator() throws -> Element {
        if case .prefixOperator(_) = peekAtNextKind() {
            return try parse(OperatorParser.self)
        }
        throw LookAheadError()
    }

    func parseOperator() throws -> Element {
        return try parse(OperatorParser.self)
    }

    func parseBinaryOperator(_ op: String) throws -> Element {
        if isNext(.binaryOperator(op)) {
            advance()
            return LeafNodeImpl(text: op)
        }
        throw LookAheadError()
    }

    func parsePunctuation(_ kind: Token.Kind) throws -> Element {
        if isNext(kind) {
            return try parse(PunctuationParser.self)
        }
        throw LookAheadError()
    }

    func parseGenericArgumentClause() throws -> GenericArgumentClause {
        return try parse(GenericArgumentClauseParser.self)
    }

    func parseExpression() throws -> Expression {
        return try parse(ExpressionParser.self)
    }

    func parseFunctionCallArgumentList() throws -> FunctionCallArgumentList {
        return try parse(FunctionCallArgumentListParser.self)
    }

    func parseVarArgs() throws -> Element {
        if case .postfixOperator("...") = peekAtNextKind() {
            return try parseOperator()
        }
        throw LookAheadError()
    }

    func parseClosureExpression() throws -> ClosureExpression {
        return try parse(ClosureExpressionParser.self)
    }

    func parsePostfixExpression() throws -> PostfixExpression {
        return try parse(PostfixExpressionParser.self)
    }

    func parsePostfixOperator() throws -> Element {
        if case .postfixOperator(_) = peekAtNextKind() {
            return try parseOperator()
        }
        throw LookAheadError()
    }

    func parsePostfixOperator(_ op: String) throws -> Element {
        if case let .postfixOperator(next) = peekAtNextKind(), next == op {
            return try parseOperator()
        }
        throw LookAheadError()
    }

    func parseArgumentNames() throws -> ArgumentNames {
        return try parse(ArgumentNamesParser.self)
    }

    func parsePrimaryExpression() throws -> PrimaryExpression {
        return try parse(PrimaryExpressionParser.self)
    }

    func parseDeclaration() throws -> Declaration {
        return try parse(DeclarationParser.self)
    }

    func parseFileStatement() throws -> Statement {
        return try parse(FileStatementParser.self)
    }

    func parseCodeBlockStatement() throws -> Statement {
        return try parse(CodeBlockStatementParser.self)
    }

    func getCodeBlockStatementParser() -> Parser<Statement> {
        return CodeBlockStatementParser(lexer: lexer, fileContents: fileContents, locationConverter: locationConverter)
    }

    func parseDefaultArgumentClause() throws -> DefaultArgumentClause {
        return try parse(DefaultArgumentClauseParser.self)
    }

    func parseInOutExpression() throws -> InOutExpression {
        return try parse(InOutExpressionParser.self)
    }

    func parseTryOperator() throws -> TryOperator {
        return try parse(TryOperatorParser.self)
    }

    func parsePrefixExpression() throws -> PrefixExpression {
        return try parse(PrefixExpressionParser.self)
    }

    func parseBinaryExpression() throws -> BinaryExpression {
        return try parse(BinaryExpressionParser.self)
    }

    func parseConditionalOperator() throws -> ConditionalOperator {
        return try parse(ConditionalOperatorParser.self)
    }

    func parseTypeCastingOperator() throws -> TypeCastingOperator {
        return try parse(TypeCastingOperatorParser.self)
    }

    func parse<T, P: Parser<T>>(_ parserType: P.Type) throws -> T {
        return try P.init(lexer: lexer, fileContents: fileContents, locationConverter: locationConverter).parse()
    }

    private func parseDeclaration<T, P: BaseDeclarationParser<T>>(_ parserType: P.Type, _ token: Token.Kind) throws -> T {
        return try P.init(lexer: lexer, fileContents: fileContents, declarationToken: token, locationConverter: locationConverter).parse()
    }

    func parseCompoundPostfixExpression<T, P: CompoundPostfixExpressionParser<T>>(_ parserType: P.Type, _ postfixExpression: PostfixExpression) throws -> T {
        return try P.init(lexer: lexer, fileContents: fileContents, postfixExpression: postfixExpression, locationConverter: locationConverter).parse()
    }

    func builder() -> ParserBuilder {
        return ParserBuilder(
                whitespaceParser: WhitespaceParser(lexer: lexer, fileContents: fileContents, locationConverter: locationConverter)
        )
    }
}
