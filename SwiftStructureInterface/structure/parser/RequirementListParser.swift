class RequirementListParser: Parser<RequirementList> {

    override func parse() throws -> RequirementList {
        return try RequirementListImpl(children: builder()
                .required { try self.parseRequirement() }
                .while(isParsed: { try self.parsePunctuation(.comma) }) {
                    try self.parseRequirement()
                }
                .build())
    }

    private func parseRequirement() throws -> Requirement {
        if let conformance = try? parseConformanceRequirement() {
            return conformance
        } else if let sameType = try? parseSameTypeRequirement() {
            return sameType
        }
        throw LookAheadError()
    }

    private func parseConformanceRequirement() throws -> Requirement {
        return try ConformanceRequirementImpl(children: builder()
                .required { try self.parseType() }
                .required { try self.parsePunctuation(.colon) }
                .optional { try self.parseType() }
                .build())
    }

    private func parseSameTypeRequirement() throws -> Requirement {
        return try SameTypeRequirementImpl(children: builder()
                .required { try self.parseType() }
                .required { try self.parseBinaryOperator("==") }
                .optional { try self.parseType() }
                .build())
    }
}
