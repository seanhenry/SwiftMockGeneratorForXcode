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
        let builder = self.builder()
                .optional { try self.parseAttributes() }
                .while { try self.parseDeclarationModifier() }
                .required { try self.parseKeyword(self.declarationToken) }
        return try parseDeclaration(builder: builder)
    }

    func parseDeclaration(builder: ParserBuilder) throws -> ResultType {
        fatalError("Override me")
    }
}
