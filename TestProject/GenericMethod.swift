protocol GenericMethod {
    func test<T>(a: T)
    func test<T: NSObject>(b: T)
    func test<T: NSObject>(c: T.Type)
    func testReturn1<T>() -> T?
    func testReturn2<T>() -> T
    func testReturn3<T: Foundation.NSObject>() -> T
    func testReturnArray<T>() -> [T]
    func testReturnDictionary<T, U>() -> [T: U]
    func test<T: AssociatedTypeProtocol>(d: T)
    func test<T: AssociatedTypeProtocol>(e: T) where T.SomeType == NSObject
    func test<T, U>(optional: T?, iuo: U!)
    func test<T>(array: [T])
    func test<T, U>(dictionary: [T: U])
    func test<T>(dictionary2: [String: T])
    func test<T, U>(nested: [T: [U?]])
}
