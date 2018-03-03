protocol AssociatedTypeProtocol {
    associatedtype SomeType
}

protocol GenericMethod {
    func test<T>(a: T)
    func test<T: NSObject>(b: T)
    func test<T: NSObject>(c: T.Type)
    func testReturn1<T>() -> T?
    func testReturn2<T>() -> T
    func testReturn3<T: NSObject>() -> T
    func test<T: AssociatedTypeProtocol>(d: T)
//    func test<T: AssociatedTypeProtocol>(e: T) where T.SomeType == NSObject // TODO: not yet supported
    func test<T, U>(f: T!, g: U?)
}

