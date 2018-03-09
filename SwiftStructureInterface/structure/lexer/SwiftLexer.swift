import Source
import Lexer

protocol SwiftLexer {

    func getPreviousEndLocation() -> LineColumn
    func getCurrentRange() -> LineColumnRange
    func isNext(_ scalar: UnicodeScalar) -> Bool
    func isNext(_ kind: Token.Kind) -> Bool
    func isNext(_ kind: [Token.Kind]) -> Bool
    func peekAtNextKind() -> Token.Kind
    func advance()
    func setCheckPoint() -> String
    func restoreCheckPoint(_ id: String)
}

extension SwiftLexer {

    func getCurrentStartLocation() -> LineColumn {
        return getCurrentRange().start
    }

    func getCurrentEndLocation() -> LineColumn {
        return getCurrentRange().end
    }
}
