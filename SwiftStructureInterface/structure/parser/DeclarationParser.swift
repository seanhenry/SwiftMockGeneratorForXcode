import Source
import Lexer

class DeclarationParser<ResultType>: Parser<ResultType> {

    private let declarationToken: Token.Kind

    required init(lexer: Lexer, sourceFile: SourceFile, declarationToken: Token.Kind) {
        self.declarationToken = declarationToken
        super.init(lexer: lexer, sourceFile: sourceFile)
    }

    required init(lexer: Lexer, sourceFile: SourceFile) {
        fatalError("Use init(lexer:sourceFile:declarationToken:)")
    }

    override func parse() -> ResultType {
        let start = getCurrentStartLocation()
        _ = parseAttributes()
        skipAccessModifier()
        guard isNext(declarationToken) else { fatalError("Expected a \(declarationToken). Check isNext(.\(declarationToken)) before parsing a protocol") }
        advance()
        return parseDeclaration(offset: convert(start)!)
    }

    func parseDeclaration(offset: Int64) -> ResultType {
        fatalError("Override me")
    }
}
