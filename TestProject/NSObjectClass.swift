// Must declare this here because plugin tests cannot resolve items in 3rd party framework
class NSObject {
    init() {} // should still use this
    var shouldNotBeMockedProperty: String?
    func shouldNotBeMocked() {}
}

protocol NSObjectProtocol {
    var shouldNotBeMockedProperty: String? { get set }
    func shouldNotBeMocked()
}

class NSObjectClass: NSObject {

    init(a: String?) {}
}
