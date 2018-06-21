
public class ElementTreeUtil {

    public init() {}

    public func findParentType(_ element: Element) -> TypeDeclaration? {
        return findParent(TypeDeclaration.self, from: element)
    }

    public func findParent<T>(_ type: T.Type, from element: Element) -> T? {
        var parent = element.parent
        while parent != nil && !(parent is T) {
            parent = parent?.parent
        }
        return parent as? T
    }
}
