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

    override func parse(start: LineColumn) -> ResultType {
        _ = parseAttributes()
        skipDeclarationModifiers()
        guard isNext(declarationToken) else { fatalError("Expected a \(declarationToken). Check isNext(.\(declarationToken)) before parsing a protocol") }
        advance()
        return parseDeclaration(start: start)
    }

    func parseDeclaration(start: LineColumn) -> ResultType {
        fatalError("Override me")
    }
}
