import Lexer
import Source

class Parser<ResultType> {

    let sourceFile: SourceFile
     let lexer: Lexer // TODO: make private

    init(lexer: Lexer, sourceFile: SourceFile) {
        self.lexer = lexer
        self.sourceFile = sourceFile
    }

    func parse() -> ResultType? {
        fatalError("override me")
    }

    func convert(_ location: SourceLocation) -> Int64? {
        let zeroBasedColumn = location.column - 1
        return LocationConverter.convert(line: location.line, column: zeroBasedColumn, in: sourceFile.content)!
    }

    func getCurrentStartLocation() -> SourceLocation {
        return getCurrentRange().start
    }

    func getCurrentEndLocation() -> SourceLocation {
        return getCurrentRange().end
    }

    func getCurrentRange() -> SourceRange {
        return lexer.look().sourceRange
    }

    func getLength(_ string: String) -> Int64 {
        return Int64(string.utf8.count)
    }

    func peekAtNextIdentifier() -> String? {
        return lexer.look().kind.namedIdentifier
    }

    func isNext(_ kind: Token.Kind) -> Bool {
        return lexer.look().kind == kind
    }

    func advance() {
        lexer.advance()
    }

    func advance(if kind: Token.Kind) {
        if isNext(kind) {
            advance()
        }
    }
}
