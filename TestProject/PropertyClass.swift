class PropertyClass {

    var property: String?

    var computed: Int {
        return 0
    }

    private(set) var privateSet: UInt?
    fileprivate(set) var filePrivateSet: UInt?

    lazy var lazyProperty: Int = {
        return 0
    }()
}
