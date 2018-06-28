public protocol KeyPathExpression: PrimaryExpression {
    // Note: This is described as a Type in the spec but a type parses nested types, etc
    var type: Identifier? { get }
    var components: KeyPathComponents { get }
}
