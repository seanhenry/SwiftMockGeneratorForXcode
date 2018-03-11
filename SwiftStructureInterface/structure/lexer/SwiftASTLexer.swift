import Lexer
import Source

class SwiftASTLexer: SwiftLexer {

    let lexer: Lexer
    var lastRange: LineColumnRange

    init(lexer: Lexer) {
        self.lexer = lexer
        lastRange = SwiftASTLexer.convert(lexer.look().sourceRange)
    }

    private static func convert(_ sourceRange: SourceRange) -> LineColumnRange {
        return LineColumnRange(start: convert(sourceRange.start), end: convert(sourceRange.end))
    }

    private static func convert(_ sourceLocation: SourceLocation) -> LineColumn {
        return LineColumn(line: sourceLocation.line, column: sourceLocation.column - 1)
    }

    private func convert(_ sourceRange: SourceRange) -> LineColumnRange {
        return SwiftASTLexer.convert(sourceRange)
    }

    private func convert(_ sourceLocation: SourceLocation) -> LineColumn {
        return SwiftASTLexer.convert(sourceLocation)
    }

    func getCurrentRange() -> LineColumnRange {
        return convert(lexer.look().sourceRange)
    }

    func getPreviousEndLocation() -> LineColumn {
        return lastRange.end
    }

    func isNext(_ scalar: UnicodeScalar) -> Bool {
        let cp = setCheckPoint()
        defer { restoreCheckPoint(cp) }
        return lexer.matchUnicodeScalar(scalar)
    }

    func advanceOperator(_ scalar: UnicodeScalar) {
        var end = getCurrentStartLocation()
        end.column += 1
        let didAdvance = lexer.matchUnicodeScalar(scalar, splitOperator: true)
        if didAdvance {
            lastRange = LineColumnRange(start: getCurrentStartLocation(), end: end)
        }
    }

    func isNext(_ kind: Token.Kind) -> Bool {
        return peekAtNextKind() == kind
    }

    func isNext(_ kind: [Token.Kind]) -> Bool {
        return kind.contains(peekAtNextKind())
    }

    func peekAtNextKind() -> Token.Kind {
        return lexer.look().kind
    }

    func advance() {
        lastRange = getCurrentRange()
        lexer.advance()
    }

    func setCheckPoint() -> String {
        return lexer.checkPoint()
    }

    func restoreCheckPoint(_ id: String) {
        lexer.restore(fromCheckpoint: id)
    }
}
