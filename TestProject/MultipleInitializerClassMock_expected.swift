@testable import TestProject

class MultipleInitializerClassMock: MultipleInitializerClass {

    convenience init() {
        self.init(f: "")
    }
}
