class TypealiasAssignmentParser: Parser<TypealiasAssignment> {

    override func parse() throws -> TypealiasAssignment {
        return try TypealiasAssignmentImpl(children: builder()
                .required { try self.parseAssignmentOperator() }
                .optional { try self.parseType() }
                .build())
    }

    private func parseAssignmentOperator() throws -> Element {
        if let op = try? parsePunctuation(.assignmentOperator) {
            return op
        } else if let op = try? parseOperator("=") {
            return op
        }
        throw LookAheadError()
    }
}
