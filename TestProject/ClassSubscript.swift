class ClassSubscript {
    subscript() -> Int {
        return 0
    }
    subscript(b: Int) -> Int {
        set {}
        get { return 0 }
    }
    private subscript(c c: Int) -> Int { return 0 }
    private(set) subscript(d d: Int) -> Int {
        set {}
        get { return 0 }
    }
}
