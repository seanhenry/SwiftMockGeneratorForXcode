import Lexer

class KeywordParser: Parser<LeafNode> {

    override func parse() throws -> LeafNode {
        if let leaf = Keywords.keywords[String(describing: peekAtNextKind())] {
            advance()
            return LeafNodeImpl(text: leaf)
        } else if isNext(.identifier("associatedtype", false)) {
            advance()
            return LeafNodeImpl(text: Keywords.associatedtype)
        } else if isNext(.booleanLiteral(false)) {
            advance()
            return LeafNodeImpl(text: Keywords.false)
        } else if isNext(.booleanLiteral(true)) {
            advance()
            return LeafNodeImpl(text: Keywords.true)
        } else {
            throw LookAheadError()
        }
    }
}
