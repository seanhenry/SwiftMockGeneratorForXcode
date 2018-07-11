@testable import TestProject

class RequiredInitializerClassMock: RequiredInitializerClass {
    convenience init() {
        self.init(a: "")
    }
}
