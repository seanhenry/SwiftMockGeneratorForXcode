public protocol Declaration: Element {
    var attributes: Attributes { get }
    var accessLevelModifier: AccessLevelModifier { get }
}
