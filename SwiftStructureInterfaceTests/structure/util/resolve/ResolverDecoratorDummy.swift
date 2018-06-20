@testable import SwiftStructureInterface

class ResolverDecoratorDummy: ResolverDecorator {

    convenience init() {
        self.init(nil)
    }

    override func resolve(_ element: Element) -> Element? {
        return nil
    }
}
