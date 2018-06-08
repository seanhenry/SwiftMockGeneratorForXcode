class TypealiasAssignmentParser: Parser<TypealiasAssignment> {

    override func parse(start: LineColumn) -> TypealiasAssignment {
        guard isNext(.assignmentOperator) else {
            return TypealiasAssignmentImpl.errorTypealiasAssignment
        }
        advance()
        let type = parseType()
        return createElement(start: start) { offset, length, text in
            return TypealiasAssignmentImpl(
                text: text,
                children: [type],
                offset: offset,
                length: length,
                type: type)
        } ?? TypealiasAssignmentImpl.errorTypealiasAssignment
    }
}
