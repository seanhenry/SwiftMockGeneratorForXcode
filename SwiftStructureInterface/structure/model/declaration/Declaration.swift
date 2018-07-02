public protocol Declaration: Statement {
    var attributes: Attributes { get }
    var accessLevelModifier: AccessLevelModifier { get }
}
