class AugmentedClassSubscriptSuper {

    subscript(b: Int) -> Int {
        return 0
    }
}

class AugmentedClassSubscript: AugmentedClassSubscriptSuper, ReadOnlySubscriptProtocol {
    subscript() -> Int {
        get {
            return 0
        }
        set {}
    }
    override subscript(b: Int) -> Int {
        set {}
        get { return 0 }
    }
}
