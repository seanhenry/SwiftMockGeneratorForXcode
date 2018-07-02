public protocol InitializerExpression: PostfixExpression {
    var postfixExpression: PostfixExpression { get }
    var argumentNames: ArgumentNames? { get }
}
