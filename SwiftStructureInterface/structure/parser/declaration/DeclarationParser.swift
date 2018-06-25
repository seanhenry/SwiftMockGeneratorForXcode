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
        // TODO: this only works for some declarations (classes for example, may have final first) but only used for protocols so far.
        do {
            return parseDeclaration(start: start, children: [
                parseAttributesAndWhitespace(),
                parseDeclarationModifiers(),
                try parseDeclarationToken(),
                parseWhitespace()
            ])
        } catch {
            fatalError("Expected a \(declarationToken). Check isNext(.\(declarationToken)) before parsing a declaration")
        }
    }

    private func parseAttributesAndWhitespace() -> [Element] {
        if isNext(.at) {
            return [parseAttributes(), parseWhitespace()]
        }
        return [parseAttributes()]
    }

    private func parseDeclarationToken() throws -> Element {
        if isNext(declarationToken) {
            return parseKeyword()
        }
        throw LookAheadError()
    }

    func parseDeclaration(start: LineColumn, children: [Any?]) -> ResultType {
        fatalError("Override me")
    }
}
