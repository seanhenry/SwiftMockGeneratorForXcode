public protocol KeyPathComponent: Element {
    var identifier: Identifier? { get }
    var postfixes: KeyPathPostfixes? { get }
}
