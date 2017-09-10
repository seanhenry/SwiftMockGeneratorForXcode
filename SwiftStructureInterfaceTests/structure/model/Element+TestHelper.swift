@testable import SwiftStructureInterface

extension Element {

    func namedChild(at index: Int) -> NamedElement? {
        return children[index] as? NamedElement
    }
}
