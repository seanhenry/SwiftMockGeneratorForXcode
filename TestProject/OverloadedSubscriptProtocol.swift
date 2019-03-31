protocol OverloadedSubscriptProtocol {
    subscript() -> Int { get }
    subscript(a: Int) -> Int { get }
    subscript(b b: Int) -> Int { get }
    subscript(c c: Int) -> Int { get }
    subscript(c c: String) -> Int { get }
}
