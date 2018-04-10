protocol DeepestCousinProtocol {
    func deepestCousin()
}

protocol DeepestSiblingProtocol {
    func deepestSibling()
}

protocol DeepestProtocol {
    func deepest()
}

protocol MiddleProtocolSibling1: DeepestCousinProtocol {
    func middleSibling1()
}

protocol MiddleProtocolSibling2 {
    func middleSibling2()
}

protocol MiddleProtocol: DeepestProtocol, DeepestSiblingProtocol {
    func middle()
}

protocol TopMostSiblingProtocol {
    func topSibling()
}

protocol TopMostProtocol: MiddleProtocol, MiddleProtocolSibling1, MiddleProtocolSibling2 {
    func topMost()
}
