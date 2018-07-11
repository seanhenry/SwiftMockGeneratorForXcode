class UnoverridableClass {
    private init(a: String) {}
    fileprivate init(b: String) {}
    final init(c: String) {}
    init() { }
    let constant: Int = 0
    static var staticProperty: Int = 0
    static func staticMethod() {}
    final var finalProperty: Int = 0
    final func finalMethod() {}
    private func privateMethod() {}
    fileprivate func filePrivateMethod() {}
    private var privateProperty: Int = 0
    fileprivate var filePrivateProperty: Int = 0
    class func classMethod() {} // not yet supported
    class var classProperty: Int { return 0 }
}

extension UnoverridableClass {

    var cannotOverrideExtensionProperty: Int {
        set {}
        get { return 0 }
    }
    func cannotOverrideExtensionMethod() {}
}
