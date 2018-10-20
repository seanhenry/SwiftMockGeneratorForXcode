class PartialSpyClass {
    var propA: Int = 0
    var readonly: Int { return 0 }
    func method() {}
    func method(a: Int, _ b: Int, c d: Int) {}
    func returnMethod() -> Int { return 0 }
    func forwardNoStubs(a: () -> ()) throws {}
    func throwing() throws -> Int { return 0 }
    func rethrowing(a: () throws -> ()) rethrows -> Int { return 0 }
}

protocol PartialSpyProtocol {
    func protocolMethod()
    var protocolProperty: Int { set get }
    var protocolReadonlyProperty: Int { get }
}
