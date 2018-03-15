class TypealiasAssignmentParser: Parser<TypealiasAssignment> {

    override func parse(start: LineColumn) -> TypealiasAssignment {
        guard isNext(.assignmentOperator) else {
            return SwiftTypealiasAssignment.errorTypealiasAssignment
        }
        advance()
        let type = parseType()
        return createElement(start: start) { offset, length, text in
            return SwiftTypealiasAssignment(
                text: text,
                children: [type],
                offset: offset,
                length: length,
                type: type)
        } ?? SwiftTypealiasAssignment.errorTypealiasAssignment
    }
}
