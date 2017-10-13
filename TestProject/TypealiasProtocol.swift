typealias Completion = (Int) -> (String)

// TODO: ready to be implemented
protocol TypealiasProtocol {
    typealias T = (String) -> ()
    func typealiasClosure(closure: Completion)
    func internalTypealiasClosure(closure: T)
}
