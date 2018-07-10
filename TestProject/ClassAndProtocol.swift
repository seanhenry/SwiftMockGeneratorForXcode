protocol ClassAndProtocolMockProtocol {
    var protocolOnlyProperty: String? { get }
    func protocolOnlyMethod()
}

protocol ClassAndProtocolProtocol {
    init(shared: Int)
    var sharedProperty: String? { get }
    func sharedMethod()
}

class ClassAndProtocol: ClassAndProtocolProtocol {
    required init(shared: Int) {}
    var sharedProperty: String? { return nil }
    func sharedMethod() { }
}
