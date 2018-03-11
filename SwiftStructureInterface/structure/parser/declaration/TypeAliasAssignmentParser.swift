class TypealiasAssignmentParser: Parser<TypealiasAssignment> {

    override func parse() -> TypealiasAssignment {
        let start = getCurrentStartLocation()
        guard isNext(.assignmentOperator) else {
            return SwiftTypealiasAssignment.errorTypealiasAssignment
        }
        advance()
        let type = parseType()
        let offset = convert(start)!
        let length = convert(getPreviousEndLocation())! - offset
        return SwiftTypealiasAssignment(
            text: getString(offset: offset, length: length)!,
            children: [type],
            offset: offset,
            length: length,
            type: type)
    }
}
