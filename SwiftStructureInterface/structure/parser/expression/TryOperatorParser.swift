class TryOperatorParser: Parser<TryOperator> {

    override func parse() throws -> TryOperator {
        return try TryOperatorImpl(children: builder()
                .required { try self.parseKeyword(.try) }
                .either({ try self.parsePunctuation(.postfixQuestion) }) {
                    try self.parsePunctuation(.postfixExclaim)
                }
                .build())
    }
}
