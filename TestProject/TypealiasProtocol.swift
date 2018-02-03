typealias TypealiasProtocolCompletion = (Int) -> (String)
typealias TypealiasedTypealiasProtocolCompletion = TypealiasProtocolCompletion

protocol TypealiasProtocol {
    typealias T = (String) -> ()
    func typealiasClosure(closure: TypealiasProtocolCompletion)
    func typealiasedTypealiasClosure(closure: TypealiasedTypealiasProtocolCompletion)
    func internalTypealiasClosure(closure: T)
    func escapingClosure(closure: @escaping TypealiasProtocolCompletion)
}
