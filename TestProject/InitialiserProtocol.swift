protocol InitialiserProtocol {

    init()
    init(a: Int, b: String, _ c: String?)
    init?(opt: Int)
    init!(iuo: Int)
    init(throwing: Int) throws
}
