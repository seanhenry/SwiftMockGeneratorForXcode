@testable import TestProject

class PrivateInitializerClassMock: PrivateInitializerClass {

    convenience init() {
        self.init(c: 0, d: 0)
    }
}
