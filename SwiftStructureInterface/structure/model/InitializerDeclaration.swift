public protocol InitializerDeclaration: Element {
    var parameters: [Parameter] { get }
    var declarations: [Element] { get }
}
