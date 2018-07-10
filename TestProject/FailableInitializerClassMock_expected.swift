@testable import TestProject

class FailableInitializerClassMock: FailableInitializerClass {
    convenience init() {
        self.init(a: "")!
    }
}
