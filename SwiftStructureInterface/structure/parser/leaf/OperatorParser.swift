class OperatorParser: Parser<LeafNode> {

    override func parse() throws -> LeafNode {
        if case let .postfixOperator(op) = peekAtNextKind() {
            advance()
            return LeafNodeImpl(text: op)
        } else if case let .prefixOperator(op) = peekAtNextKind() {
            advance()
            return LeafNodeImpl(text: op)
        } else if case let .binaryOperator(op) = peekAtNextKind() {
            advance()
            return LeafNodeImpl(text: op)
        } else if isNext(.assignmentOperator) {
            advance()
            return LeafNodeImpl(text: "=")
        }
        throw LookAheadError()
    }
}
