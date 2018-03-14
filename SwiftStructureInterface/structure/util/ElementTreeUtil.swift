
public class ElementTreeUtil {

    public init() {}

    public func findParentType(_ element: Element) -> TypeDeclaration? {
        var parent = element.parent
        while parent != nil && !(parent is TypeDeclaration) {
            parent = parent?.parent
        }
        return parent as? TypeDeclaration
    }
}
