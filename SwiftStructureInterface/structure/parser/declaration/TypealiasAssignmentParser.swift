class TypealiasAssignmentParser: Parser<TypealiasAssignment> {

    override func parse() throws -> TypealiasAssignment {
        return try TypealiasAssignmentImpl(children: builder()
                .required { try self.parsePunctuation(.assignmentOperator) }
                .optional { try self.parseType() }
                .build())
    }
}
