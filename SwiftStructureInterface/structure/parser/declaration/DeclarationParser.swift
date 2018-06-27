import Source
import Lexer

class DeclarationParser<ResultType>: Parser<ResultType> {

    private let declarationToken: Token.Kind

    required init(lexer: SwiftLexer, fileContents: String, declarationToken: Token.Kind, locationConverter: CachedLocationConverter) {
        self.declarationToken = declarationToken
        super.init(lexer: lexer, fileContents: fileContents, locationConverter: locationConverter)
    }

    required init(lexer: SwiftLexer, fileContents: String, locationConverter: CachedLocationConverter) {
        fatalError("Use init(lexer:fileContents:declarationToken:locationConverter:)")
    }

    override func parse() throws -> ResultType {
        // TODO: this only works for some declarations (classes for example, may have final first) but only used for protocols so far.
        let builder = self.builder()
                .optional { try self.parseAttributes() }
                .while { try self.parseDeclarationModifier() }
                .required { try self.parseDeclarationToken() }
        return try parseDeclaration(builder: builder)
    }

    private func parseDeclarationToken() throws -> Element {
        if isNext(declarationToken) {
            return try parseKeyword()
        }
        throw LookAheadError()
    }

    func parseDeclaration(start: LineColumn, children: [Any?]) -> ResultType {
        fatalError("Override me")
    }

    func parseDeclaration(builder: ParserBuilder) throws -> ResultType {
        fatalError("Override me")
    }
}
