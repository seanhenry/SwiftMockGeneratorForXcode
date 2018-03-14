class TypealiasAssignmentParser: Parser<TypealiasAssignment> {

    override func parse(offset: Int64) -> TypealiasAssignment {
        guard isNext(.assignmentOperator) else {
            return SwiftTypealiasAssignment.errorTypealiasAssignment
        }
        advance()
        let type = parseType()
        return createElement(offset: offset) { length, text in
            return SwiftTypealiasAssignment(
                text: text,
                children: [type],
                offset: offset,
                length: length,
                type: type)
        } ?? SwiftTypealiasAssignment.errorTypealiasAssignment
    }
}
