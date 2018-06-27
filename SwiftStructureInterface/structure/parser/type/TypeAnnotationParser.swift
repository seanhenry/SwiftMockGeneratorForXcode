class TypeAnnotationParser: Parser<TypeAnnotation> {

    override func parse() throws -> TypeAnnotation {
        return try TypeAnnotationImpl(children: builder()
                .required { try self.parsePunctuation(.colon) }
                .optional { try self.parseAttributes() }
                .optional { try self.parseKeyword(.inout) }
                .optional { try self.parseType() }
                .build())
    }
}
