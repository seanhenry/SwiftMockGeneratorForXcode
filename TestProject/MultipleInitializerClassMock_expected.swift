@testable import MockableTypes

class MultipleInitializerClassMock: MultipleInitializerClass {
    convenience init() {
        self.init(f: "")
    }
}
