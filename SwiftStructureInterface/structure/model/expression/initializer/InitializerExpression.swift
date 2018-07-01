public protocol InitializerExpression: Expression {
    var postfixExpression: PostfixExpression { get }
    var argumentNames: ArgumentNames? { get }
}
