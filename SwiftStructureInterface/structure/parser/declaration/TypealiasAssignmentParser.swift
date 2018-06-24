class TypealiasAssignmentParser: Parser<TypealiasAssignment> {

    override func parse(start: LineColumn) -> TypealiasAssignment {
        guard isNext(.assignmentOperator) else {
            return TypealiasAssignmentImpl.emptyTypealiasAssignment
        }
        advance()
        return TypealiasAssignmentImpl(children: [
            LeafNodeImpl(text: "="),
            parseWhitespace(),
            parseType()
        ])
    }
}
