
class ElementTreeUtil {

    func findParentType(_ element: Element) -> SwiftTypeElement? {
        var parent = element.parent
        while parent != nil && !(parent is SwiftTypeElement) {
            parent = parent?.parent
        }
        return parent as? SwiftTypeElement
    }
}
