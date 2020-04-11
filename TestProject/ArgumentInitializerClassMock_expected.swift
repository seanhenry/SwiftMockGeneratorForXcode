@testable import TestProject

class ArgumentInitializerClassMock: ArgumentInitializerClass {

    convenience init() {
        self.init(a: 0, b: "", nil)
    }
}
