class MultipleInitializerClass {

    init(a: String, b: Int, c: UInt) {}
    init(d: String, e: Int) {}
    init(f: String) {} // should choose simplest
}
