import Source
import Lexer

class DeclarationParser<ResultType>: Parser<ResultType> {

    private let declarationToken: Token.Kind

    required init(lexer: SwiftLexer, fileContents: String, declarationToken: Token.Kind) {
        self.declarationToken = declarationToken
        super.init(lexer: lexer, fileContents: fileContents)
    }

    required init(lexer: SwiftLexer, fileContents: String) {
        fatalError("Use init(lexer:fileContents:declarationToken:)")
    }

    override func parse(offset: Int64) -> ResultType {
        _ = parseAttributes()
        skipDeclarationModifiers()
        guard isNext(declarationToken) else { fatalError("Expected a \(declarationToken). Check isNext(.\(declarationToken)) before parsing a protocol") }
        advance()
        return parseDeclaration(offset: offset)
    }

    func parseDeclaration(offset: Int64) -> ResultType {
        fatalError("Override me")
    }
}
