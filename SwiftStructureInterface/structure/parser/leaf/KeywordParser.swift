import Lexer

class KeywordParser: Parser<LeafNode> {

    override func parse(start: LineColumn) -> LeafNode {
        if let leaf = Keywords.keywords[String(describing: peekAtNextKind())] {
            advance()
            return leaf
        } else if isNext(.identifier("associatedtype", false)) {
            advance()
            return Keywords.associatedtype
        } else if isNext(.booleanLiteral(false)) {
            advance()
            return Keywords.false
        } else if isNext(.booleanLiteral(true)) {
            advance()
            return Keywords.true
        } else {
            return LeafNodeImpl.emptyLeafNode
        }
    }
}
