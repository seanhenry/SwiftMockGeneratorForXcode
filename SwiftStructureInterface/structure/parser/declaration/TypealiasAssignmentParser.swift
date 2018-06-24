class TypealiasAssignmentParser: Parser<TypealiasAssignment> {

    override func parse(start: LineColumn) -> TypealiasAssignment {
        guard isNext(.assignmentOperator) else {
            return TypealiasAssignmentImpl.emptyTypealiasAssignment
        }
        advance()
        let type = parseType()
        return createElement(start: start) { offset, length, text in
            return TypealiasAssignmentImpl(
                text: text,
                offset: offset,
                length: length,
                type: type)
        } ?? TypealiasAssignmentImpl.emptyTypealiasAssignment
    }
}
