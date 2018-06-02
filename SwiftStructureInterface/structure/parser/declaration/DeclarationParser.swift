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
        // TODO: this only works for some declarations (classes for example, may have final first) but only used for protocols so far.
        let accessLevelModifier = parseAccessLevelModifier()
        skipDeclarationModifiers()
        guard isNext(declarationToken) else { fatalError("Expected a \(declarationToken). Check isNext(.\(declarationToken)) before parsing a protocol") }
        advance()
        return parseDeclaration(start: start, accessLevelModifier: accessLevelModifier)
    }

    func parseDeclaration(start: LineColumn, accessLevelModifier: AccessLevelModifier) -> ResultType {
        fatalError("Override me")
    }
}
