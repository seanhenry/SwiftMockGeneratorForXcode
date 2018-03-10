protocol ThrowingProtocol {
    func throwingMethod() throws
    func throwingClosure(closure: () throws -> ())
    func throwingClosureArgument(closure: (String) throws -> (String))
    func rethrowsMethod(closure: () throws -> ()) rethrows
}
