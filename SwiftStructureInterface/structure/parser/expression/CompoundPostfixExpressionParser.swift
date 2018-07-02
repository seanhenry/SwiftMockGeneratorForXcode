class CompoundPostfixExpressionParser<ResultType>: Parser<ResultType> {

    let postfixExpression: PostfixExpression

    required init(lexer: SwiftLexer, fileContents: String, postfixExpression: PostfixExpression, locationConverter: CachedLocationConverter) {
        self.postfixExpression = postfixExpression
        super.init(lexer: lexer, fileContents: fileContents, locationConverter: locationConverter)
    }

    required init(lexer: SwiftLexer, fileContents: String, locationConverter: CachedLocationConverter) {
        fatalError("Use init(lexer:fileContents:primaryExpression:locationConverter:)")
    }
}
