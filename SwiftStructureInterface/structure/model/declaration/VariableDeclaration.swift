public protocol VariableDeclaration: NamedElement, Declaration {
    var typeAnnotation: TypeAnnotation { get }
    var getterSetterKeywordBlock: GetterSetterKeywordBlock { get }
    var declarations: [Element] { get }
    var codeBlock: CodeBlock? { get }
}
