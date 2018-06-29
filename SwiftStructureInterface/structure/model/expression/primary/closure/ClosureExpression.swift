public protocol ClosureExpression: PrimaryExpression {
    var closureSignature: ClosureSignature? { get }
    var statements: [Element] { get } // TODO: make me [Statement]
}
