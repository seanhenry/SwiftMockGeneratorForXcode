@testable import TestProject

class EmptyFailableInitializerClassMock: EmptyFailableInitializerClass {

    override init() {
        super.init()!
    }
}
